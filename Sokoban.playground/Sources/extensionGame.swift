import PlaygroundSupport
import SpriteKit

let tileSize: CGFloat = 64
let columns = 10
let lines = 10

public class GameScene: SKScene {
    var emptyBins: Int = 4
    
    public override func didMove (to view: SKView) {
        loadButtons()
        loadGameMap()
    }

    func touchButton (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        let gameMap = self.childNode(withName: "gameMap")!
        let player = gameMap.childNode(withName: "player")!
        
        if button.name == "arrowLeft" {
            move("Left", from: player.position, x: -tileSize, y: 0)
        } else if button.name == "arrowRight" {
            move("Right", from: player.position, x: tileSize, y: 0)
        } else if button.name == "arrowUp" {
            move("Back", from: player.position, x: 0, y: tileSize)
        } else if button.name == "arrowDown" {
           move("Front", from: player.position, x: 0, y: -tileSize)
        }
    }
    
    public override func touchesBegan (_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchButton(atPoint: t.location(in: self))
        }
    }
    
    func move (_ direction: String, from position: CGPoint, x: CGFloat, y: CGFloat) {
        let gameMap = self.childNode(withName: "gameMap")!
        let oldPlayer = gameMap.childNode(withName: "player")!
        let player = createPlayer(imageNamed: "player\(direction)", position: position)
        
        oldPlayer.removeFromParent()
        gameMap.addChild(player)
        
        let node = gameMap.atPoint(CGPoint(x: player.position.x + x, y: player.position.y + y))
        let move = SKAction.moveBy(x: x, y: y, duration: 0.1)
        
        if node.name == "garbage" {
            // verify where it's going
            let other_node = gameMap.atPoint(CGPoint(x: player.position.x + 2*x, y: player.position.y + 2*y))
            
            if other_node.name == "bin" {
                node.run(move)
                player.run(move)
                
                // delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // change the color of the binBlue
                    gameMap.addChild(self.newObject(name: "fullBin", position: other_node.position))

                    // remove empty bin and garbage from parent
                    other_node.removeFromParent()
                    node.removeFromParent()
                    
                    self.emptyBins -= 1
                    
                    if self.emptyBins == 0 {
                        print("win!!!!")
                    }
                }
            } else if other_node.name != "tree" && other_node.name != "garbage" {
                node.run(move)
                player.run(move)
            }
        } else if node.name != "tree" && node.name != "bin" {
            player.run(move)
        }
    }
    
    func loadButtons () {
        createButton(imageNamed: "arrowLeft", position: CGPoint(x: (scene?.size.width)! * -0.4, y: (scene?.size.height)! * 0))
        createButton(imageNamed: "arrowDown", position: CGPoint(x: (scene?.size.width)! * -0.35, y: (scene?.size.height)! * -0.065))
        createButton(imageNamed: "arrowUp", position: CGPoint(x: (scene?.size.width)! * -0.35, y: (scene?.size.height)! * 0.065))
        createButton(imageNamed: "arrowRight", position: CGPoint(x: (scene?.size.width)! * -0.3, y: (scene?.size.height)! * 0))
    }
    
    func loadGameMap () {
        // grass background
        let gameMap = SKSpriteNode(imageNamed: "grassMap")
        gameMap.name = "gameMap"
        gameMap.position = CGPoint(x: (scene?.size.width)! * 0.13, y: 0)
        
        // gameMap limits and middle
        let width = gameMap.frame.width - 10 // 10 -> grassMap margins
        let height = gameMap.frame.height - 10
        let xRange = SKRange(lowerLimit: (tileSize - width)/2, upperLimit: (width - tileSize)/2)
        let yRange = SKRange(lowerLimit: (tileSize - height)/2, upperLimit: (height - tileSize)/2)
        let xMiddle = xRange.lowerLimit + CGFloat(columns/2) * tileSize
        let yMiddle = yRange.lowerLimit + CGFloat(lines/2) * tileSize
        
        // trees
        for i in 0...(columns-1) {
            let j = CGFloat(i)
            gameMap.addChild(self.newObject(name: "tree", position: matrix(x: j, y: 0, xRange, yRange)))
            gameMap.addChild(self.newObject(name: "tree", position: matrix(x: j, y: 9, xRange, yRange)))
        }
        
        for i in 1...(lines-2) {
            let j = CGFloat(i)
            gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 0, y: j, xRange, yRange)))
            gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 9, y: j, xRange, yRange)))
        }
        
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 8, y: 8, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 1, y: 6, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 2, y: 6, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 4, y: 6, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 5, y: 6, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 8, y: 4, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 1, y: 3, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "tree", position: matrix(x: 5, y: 1, xRange, yRange)))
        
        // garbages
        gameMap.addChild(self.newObject(name: "garbage", position: matrix(x: 7, y: 7, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "garbage", position: matrix(x: 3, y: 6, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "garbage", position: matrix(x: 6, y: 4, xRange, yRange)))
        gameMap.addChild(self.newObject(name: "garbage", position: matrix(x: 4, y: 3, xRange, yRange)))
        
        // bins
        gameMap.addChild(self.newBin(color: "Blue", position: matrix(x: 6, y: 2, xRange, yRange)))
        gameMap.addChild(self.newBin(color: "Green", position: matrix(x: 1, y: 1, xRange, yRange)))
        gameMap.addChild(self.newBin(color: "Red", position: matrix(x: 3, y: 7, xRange, yRange)))
        gameMap.addChild(self.newBin(color: "Yellow", position: matrix(x: 8, y: 7, xRange, yRange)))
        
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
    return CGPoint(x: xRange.lowerLimit + posX*tileSize, y: yRange.lowerLimit + (CGFloat(lines)-1 - posY)*tileSize)
}
