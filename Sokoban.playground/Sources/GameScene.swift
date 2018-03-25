import PlaygroundSupport
import SpriteKit

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
        arrowLeftPos = CGPoint(x: (scene?.size.width)! * 0.3, y: 0)
        arrowDownPos = CGPoint(x: (scene?.size.width)! * 0.35, y: (scene?.size.height)! * -0.065)
        arrowUpPos = CGPoint(x: (scene?.size.width)! * 0.35, y: (scene?.size.height)! * 0.065)
        arrowRightPos = CGPoint(x: (scene?.size.width)! * 0.4, y: 0)
        
        loadButtons()
        loadGameMap()
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
        
        if node.name == "garbage" {
            // verify where it's going
            let other_node = gameMap.atPoint(CGPoint(x: player.position.x + 2*x, y: player.position.y + 2*y))
            
            if other_node.name != "tree" && other_node.name != "garbage" && other_node.name != "fullBin" {
                self.movement(object: node, x, y)
                self.movement(object: player, x, y)
            }
            
            if other_node.name == "bin" {
                // delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // change the color of the binBlue
                    gameMap.addChild(self.newObject(name: "fullBin", position: other_node.position))

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
            } else {
                var counter = 0
                var nearNodes: [SKNode] = []
                
                let nearRight = gameMap.atPoint(CGPoint(x: node.position.x + tileSize, y: node.position.y))
                let nearDown = gameMap.atPoint(CGPoint(x: node.position.x, y: node.position.y - tileSize))
                let nearLeft = gameMap.atPoint(CGPoint(x: node.position.x - tileSize, y: node.position.y))
                let nearUp = gameMap.atPoint(CGPoint(x: node.position.x, y: node.position.y + tileSize))
                
                nearNodes.append(nearRight)
                nearNodes.append(nearDown)
                nearNodes.append(nearLeft)
                nearNodes.append(nearUp)
                
                for node in nearNodes {
                    if node.name == "tree" || node.name == "bin" {
                        counter += 1
                    }
                }
                
                if counter >= 2 {
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
        gameMap.position = CGPoint(x: (scene?.size.width)! * -0.13, y: 0)
        
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
        gameMap.addChild(self.newObject(name: "garbage", position: matrix(x: 7, y: 5, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "garbage", position: matrix(x: 3, y: 5, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "garbage", position: matrix(x: 6, y: 3, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "garbage", position: matrix(x: 4, y: 2, xRange, yRange)))
        
        // bins
        gameMap.addChild(self.newBin(color: "Blue", position: matrix(x: 6, y: 2, xRange, yRange)))
        gameMap.addChild(self.newBin(color: "Green", position: matrix(x: 1, y: 1, xRange, yRange)))
        gameMap.addChild(self.newBin(color: "Red", position: matrix(x: 3, y: 6, xRange, yRange)))
        gameMap.addChild(self.newBin(color: "Yellow", position: matrix(x: 8, y: 5, xRange, yRange)))
        
        // player
        let player = self.createPlayer(imageNamed: "playerFront", position: CGPoint(x: xMiddle, y: yMiddle))
        gameMap.addChild(player)
        
        // limit the players's movements according to the map
        player.constraints = [SKConstraint.positionX(xRange, y: yRange)]
        
        // add to the tree
        self.addChild(gameMap)
    }
    
    func newObject (name: String, position: CGPoint) -> SKSpriteNode {
        let object = SKSpriteNode(imageNamed: name)
        object.position = position
        object.name = name
        
        if name == "garbage" {
            object.zPosition = 1
        } else {
            object.zPosition = 0
        }
        
        return object
    }
    
    func newBin (color: String, position: CGPoint) -> SKSpriteNode {
        let bin = SKSpriteNode(imageNamed: "bin\(color)")
        
        bin.position = position
        bin.name = "bin"
        bin.zPosition = 0
        
        return bin
    }

    func createPlayer (imageNamed name: String, position: CGPoint) -> SKSpriteNode {
        let player = SKSpriteNode(imageNamed: name)
        player.name = "player"
        player.position = position
        player.zPosition = 2
        
        return player
    }
    
    func createButton (imageNamed name: String, position: CGPoint) {
        let button = SKSpriteNode(imageNamed: name)
        button.name = name
        button.position = position
        
        self.addChild(button)
    }
    
    
}

// convert position
func matrix (x posX: CGFloat, y posY: CGFloat, _ xRange: SKRange, _ yRange: SKRange) -> CGPoint {
    return CGPoint(x: xRange.lowerLimit + posX*tileSize, y: yRange.lowerLimit + (lines-1 - posY)*tileSize)
}
