import PlaygroundSupport
import SpriteKit

// 1024 x 768

let tileSize: CGFloat = 64
let columns: CGFloat = 10
let lines: CGFloat = 8
let frames: CGFloat = 4

var arrowLeftPos = CGPoint(x: 0, y: 0)
var arrowDownPos = CGPoint(x: 0, y: 0)
var arrowUpPos = CGPoint(x: 0, y: 0)
var arrowRightPos = CGPoint(x: 0, y: 0)

public class GameScene: SKScene {
    var emptyBins: Int = 4
    
    public override func didMove (to view: SKView) {
        arrowLeftPos = CGPoint(x: 288, y: -160)
        arrowDownPos = CGPoint(x: 352, y: -224)
        arrowUpPos = CGPoint(x: 352, y: -96)
        arrowRightPos = CGPoint(x: 416, y: -160)
        
        self.loadLegend()
        self.loadButtons()
        self.loadGameMap()
    }

    func touchButton (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        let gameMap = self.childNode(withName: "gameMap")!
        let player = gameMap.childNode(withName: "player")!
        
        if button.name == "arrowLeft" {
            self.createButton(imageNamed: "arrowLeft_h", position: arrowLeftPos)
            self.move("Left", from: player.position, x: -tileSize, y: 0)
        } else if button.name == "arrowRight" {
            self.createButton(imageNamed: "arrowRight_h", position: arrowRightPos)
            self.move("Right", from: player.position, x: tileSize, y: 0)
        } else if button.name == "arrowUp" {
            self.createButton(imageNamed: "arrowUp_h", position: arrowUpPos)
            self.move("Back", from: player.position, x: 0, y: tileSize)
        } else if button.name == "arrowDown" {
            self.createButton(imageNamed: "arrowDown_h", position: arrowDownPos)
            self.move("Front", from: player.position, x: 0, y: -tileSize)
        }
    }
    
    func touchEnd (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        
        if button.name == "arrowLeft_h" || button.name == "arrowRight_h" || button.name == "arrowUp_h" || button.name == "arrowDown_h" {
            button.removeFromParent()
        }
    }
    
    public override func touchesBegan (_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchButton(atPoint: t.location(in: self))
        }
    }
    
    public override func touchesEnded (_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchEnd(atPoint: t.location(in: self))
        }
    }
    
    func move (_ direction: String, from position: CGPoint, x: CGFloat, y: CGFloat) {
        let gameMap = self.childNode(withName: "gameMap")!
        let oldPlayer = gameMap.childNode(withName: "player")!
        let player = createPlayer(imageNamed: "player\(direction)", position: position)
        
        oldPlayer.removeFromParent()
        gameMap.addChild(player)
        
        let node = gameMap.atPoint(CGPoint(x: player.position.x + x, y: player.position.y + y))
        
        if node.name!.prefix(7) == "garbage" {
            let indexGarbage = node.name!.index(node.name!.startIndex, offsetBy: 7)
            let colorGarbage = node.name![indexGarbage...]
            
            // verify where it's going
            let other_node = gameMap.atPoint(CGPoint(x: player.position.x + 2*x, y: player.position.y + 2*y))
            
            if other_node.name != "tree" && other_node.name!.prefix(7) != "garbage" && other_node.name != "fullBin" && other_node.name!.prefix(3) != "bin" {
                self.movement(object: node, x, y)
                self.movement(object: player, x, y)
            }
            
            if other_node.name!.prefix(3) == "bin" {
                let indexBin = other_node.name!.index(other_node.name!.startIndex, offsetBy: 3)
                let colorBin = other_node.name![indexBin...]
                
                if colorGarbage == colorBin {
                    self.movement(object: node, x, y)
                    self.movement(object: player, x, y)
                    
                    // delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        // change the color of the bin
                        gameMap.addChild(self.newObject(folder: "Bins", name: "fullBin", position: other_node.position))
                        
                        // remove empty bin and garbage from parent
                        other_node.removeFromParent()
                        node.removeFromParent()
                        
                        self.emptyBins -= 1
                        
                        if self.emptyBins == 0 {
                            let wonScene = SKScene(fileNamed: "Scene")!
                            wonScene.backgroundColor = #colorLiteral(red: 0.5480121216, green: 0.3523743953, blue: 0.7093039155, alpha: 1)
                            
                            self.view?.presentScene(wonScene)
                        }
                    }
                }
            } else {
                var lost = false
                var nearNodes: [SKNode] = []
                var pinned: [Bool] = [false, false, false, false] // 0 - right; 1 - down; 2 - left; 3 - up
                
                let nearRight = gameMap.atPoint(CGPoint(x: node.position.x + tileSize, y: node.position.y))
                let nearDown = gameMap.atPoint(CGPoint(x: node.position.x, y: node.position.y - tileSize))
                let nearLeft = gameMap.atPoint(CGPoint(x: node.position.x - tileSize, y: node.position.y))
                let nearUp = gameMap.atPoint(CGPoint(x: node.position.x, y: node.position.y + tileSize))
                
                nearNodes.append(nearRight)
                nearNodes.append(nearDown)
                nearNodes.append(nearLeft)
                nearNodes.append(nearUp)
                
                for i in 0...(nearNodes.count-1) {
                    if nearNodes[i].name == "tree" || nearNodes[i].name == "fullBin" {
                        pinned[i] = true
                    }
                }
                
                for i in 0...3 {
                    if pinned[i] && pinned[(i+1)%4] {
                        lost = true
                        break
                    }
                }
                
                if lost {
                    let lostScene = SKScene(fileNamed: "Scene")!
                    lostScene.backgroundColor = #colorLiteral(red: 0.3287855243, green: 0.3323060302, blue: 0.3478847121, alpha: 1)
                    
                    // delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.view?.presentScene(lostScene)
                    }
                }
            }
            
        } else if node.name != "tree" && node.name != "bin" && node.name != "fullBin" {
            self.movement(object: player, x, y)
        }
    }
    
    func movement (object: SKNode, _ x: CGFloat, _ y: CGFloat) {
        for _ in 1...Int(frames) {
            object.position = CGPoint(x: object.position.x + (x/frames), y: object.position.y + (y/frames))
        }
    }
    
    func loadLegend () {
        // icons
        self.addChild(self.newObject(folder: "Bins", name: "binBlue", position: CGPoint(x: 256, y: 240)))
        self.addChild(self.newObject(folder: "Bins", name: "binGreen", position: CGPoint(x: 256, y: 176)))
        self.addChild(self.newObject(folder: "Bins", name: "binRed", position: CGPoint(x: 256, y: 112)))
        self.addChild(self.newObject(folder: "Bins", name: "binYellow", position: CGPoint(x: 256, y: 48)))
        
        // names
        self.createLabel(text: "Paper", position: CGPoint(x: 307, y: 224))
        self.createLabel(text: "Glass", position: CGPoint(x: 307, y: 160))
        self.createLabel(text: "Plastic", position: CGPoint(x: 307, y: 96))
        self.createLabel(text: "Metal", position: CGPoint(x: 307, y: 32))
    }
    
    func loadButtons () {
        createButton(imageNamed: "arrowLeft", position: arrowLeftPos)
        createButton(imageNamed: "arrowDown", position: arrowDownPos)
        createButton(imageNamed: "arrowUp", position: arrowUpPos)
        createButton(imageNamed: "arrowRight", position: arrowRightPos)
    }
    
    func loadGameMap () {
        // grass background
        let gameMap = SKSpriteNode(imageNamed: "grassMap")
        gameMap.name = "gameMap"
        gameMap.position = CGPoint(x: -128, y: 0)
        
        // gameMap limits and middle
        let width = gameMap.frame.width - 10 // 10 -> grassMap margins
        let height = gameMap.frame.height - 10
        let xRange = SKRange(lowerLimit: (tileSize - width)/2, upperLimit: (width - tileSize)/2)
        let yRange = SKRange(lowerLimit: (tileSize - height)/2, upperLimit: (height - tileSize)/2)
        let xMiddle = xRange.lowerLimit + columns/2 * tileSize
        let yMiddle = yRange.lowerLimit + lines/2 * tileSize
        
        // trees
        for i in 0...(Int(columns)-1) {
            let j = CGFloat(i)
            gameMap.addChild(self.newObject(name: "tree", position: matrix(x: j, y: 0, xRange, yRange)))
            gameMap.addChild(self.newObject(name: "tree", position: matrix(x: j, y: lines-1, xRange, yRange)))
        }
        
        for i in 1...(Int(lines)-2) {
            let j = CGFloat(i)
            gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 0, y: j, xRange, yRange)))
            gameMap.addChild(self.newObject(name: "tree", position: matrix(x: columns-1, y: j, xRange, yRange)))
        }
        
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 8, y: 6, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 1, y: 5, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 2, y: 5, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 4, y: 5, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 5, y: 5, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 8, y: 4, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 1, y: 3, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 5, y: 1, xRange, yRange)))
        
        // garbages
        gameMap.addChild(self.newObject(folder: "Garbages", name: "garbageGreen", position: matrix(x: 7, y: 5, xRange, yRange)))
        gameMap.addChild(self.newObject(folder: "Garbages", name: "garbageRed", position: matrix(x: 3, y: 5, xRange, yRange)))
        gameMap.addChild(self.newObject(folder: "Garbages", name: "garbageBlue", position: matrix(x: 6, y: 3, xRange, yRange)))
        gameMap.addChild(self.newObject(folder: "Garbages", name: "garbageYellow", position: matrix(x: 4, y: 2, xRange, yRange)))
        
        // bins
        gameMap.addChild(self.newObject(folder: "Bins", name: "binBlue", position: matrix(x: 6, y: 2, xRange, yRange)))
        gameMap.addChild(self.newObject(folder: "Bins", name: "binGreen", position: matrix(x: 1, y: 1, xRange, yRange)))
        gameMap.addChild(self.newObject(folder: "Bins", name: "binRed", position: matrix(x: 3, y: 6, xRange, yRange)))
        gameMap.addChild(self.newObject(folder: "Bins", name: "binYellow", position: matrix(x: 8, y: 5, xRange, yRange)))
        
        // player
        let player = self.createPlayer(imageNamed: "playerFront", position: CGPoint(x: xMiddle, y: yMiddle))
        gameMap.addChild(player)
        
        // limit the players's movements according to the map
        player.constraints = [SKConstraint.positionX(xRange, y: yRange)]
        
        // add to the tree
        self.addChild(gameMap)
    }
    
    func newObject (folder: String, name: String, position: CGPoint) -> SKSpriteNode {
        let object = SKSpriteNode(imageNamed: "\(folder)/\(name)")
        object.position = position
        object.name = name
        
        if name.prefix(7) == "garbage" {
            object.zPosition = 1
        } else {
            object.zPosition = 0
        }
        
        return object
    }
    
    func newObject (name: String, position: CGPoint) -> SKSpriteNode {
        let object = SKSpriteNode(imageNamed: name)
        object.position = position
        object.name = name
        
        if name.prefix(7) == "garbage" {
            object.zPosition = 1
        } else {
            object.zPosition = 0
        }
        
        return object
    }

    func createPlayer (imageNamed name: String, position: CGPoint) -> SKSpriteNode {
        let player = SKSpriteNode(imageNamed: "Player/\(name)")
        player.name = "player"
        player.position = position
        player.zPosition = 2
        
        return player
    }
    
    func createButton (imageNamed name: String, position: CGPoint) {
        let button = SKSpriteNode(imageNamed: "Arrows/\(name)")
        button.name = name
        button.position = position
        
        self.addChild(button)
    }
    
    func createLabel (text: String, position: CGPoint) {
        let label = SKLabelNode(fontNamed: "PressStart2P-Regular")
        label.text = text
        label.fontSize = 18
        label.position = position
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(label)
    }
}

// convert position
func matrix (x posX: CGFloat, y posY: CGFloat, _ xRange: SKRange, _ yRange: SKRange) -> CGPoint {
    return CGPoint(x: xRange.lowerLimit + posX*tileSize, y: yRange.lowerLimit + (lines-1 - posY)*tileSize)
}
