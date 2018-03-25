import PlaygroundSupport
import SpriteKit

let tileSize: CGFloat = 64

public class GameScene: SKScene {
    var trees: [SKSpriteNode] = []
    var garbages: [SKSpriteNode] = []
    var bins: [SKSpriteNode] = []
    var fullBins: [SKSpriteNode] = []
    
    var columns = 10
    var lines = 10
    
    public override func didMove (to view: SKView) {
        loadBackground()
        loadGameMap()
    }

    func touchDown (atPoint pos: CGPoint) {
        let node = self.atPoint(pos)
        
        if node.name == "arrowLeft" {
            moveBy(x: -tileSize, y: 0)
        } else if node.name == "arrowRight" {
            moveBy(x: tileSize, y: 0)
        } else if node.name == "arrowUp" {
            moveBy(x: 0, y: tileSize)
        } else if node.name == "arrowDown" {
            moveBy(x: 0, y: -tileSize)
        }
    }
    
    public override func touchesBegan (_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchDown(atPoint: t.location(in: self))
        }
    }
    
    func moveBy (x: CGFloat, y: CGFloat) {
        let gameMap = self.childNode(withName: "gameMap")!
        let player = gameMap.childNode(withName: "player")!
        let node = gameMap.atPoint(CGPoint(x: player.position.x + x, y: player.position.y + y))
        
        let move = SKAction.moveBy(x: x, y: y, duration: 0.1)
        
        if node.name == "garbage" {
            // verify where it's going
            let other_node = gameMap.atPoint(CGPoint(x: player.position.x + 2*x, y: player.position.y + 2*y))
            
            if other_node.name == "bin" {
                node.run(move)
                
                // delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // change the color of the binBlue
                    gameMap.addChild(self.newObject(name: "fullBin", vector: &self.fullBins, position: other_node.position))
                    
                    // remove empty binBlue and garbage from parent and from arrays
                    other_node.removeFromParent()
                    node.removeFromParent()
                    
                    
                    
                    
                    
//                    let index = self.bins.index(of: other_node)
//                    self.bins.remove(at: index)
                    
                    
                    
                    
                    
                    
                    if self.bins.count == 0 {
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
    
    func loadBackground () {
        // fazer o background
        
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
        let xMiddle = xRange.lowerLimit + CGFloat(Int(columns/2)) * tileSize
        let yMiddle = yRange.lowerLimit + CGFloat(Int(lines/2)) * tileSize
        
        // trees
        for i in 0...(columns-1) {
            let j = CGFloat(i)
            gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: (xRange.lowerLimit + j*tileSize), y: yRange.upperLimit)))
            gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: (xRange.lowerLimit + j*tileSize), y: yRange.lowerLimit)))
        }
        
        for i in 1...(lines-2) {
            let j = CGFloat(i)
            gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: xRange.upperLimit, y: (yRange.lowerLimit + j*tileSize))))
            gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: xRange.lowerLimit, y: (yRange.lowerLimit + j*tileSize))))
        }
        
        gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: xRange.lowerLimit + 8*tileSize, y: (yRange.lowerLimit + tileSize))))
        gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: xRange.lowerLimit + tileSize, y: (yRange.lowerLimit + 3*tileSize))))
        gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: xRange.lowerLimit + 2*tileSize, y: (yRange.lowerLimit + 3*tileSize))))
        gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: xRange.lowerLimit + 4*tileSize, y: (yRange.lowerLimit + 3*tileSize))))
        gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: xRange.lowerLimit + 5*tileSize, y: (yRange.lowerLimit + 3*tileSize))))
        gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: xRange.lowerLimit + 8*tileSize, y: (yRange.lowerLimit + 5*tileSize))))
        gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: xRange.lowerLimit + tileSize, y: (yRange.lowerLimit + 6*tileSize))))
        gameMap.addChild(self.newObject(name: "tree", vector: &self.trees, position: CGPoint(x: xRange.lowerLimit + 5*tileSize, y: (yRange.lowerLimit + 8*tileSize))))
        
        // garbages
        gameMap.addChild(self.newObject(name: "garbage", vector: &self.garbages, position: CGPoint(x: xRange.lowerLimit + 7*tileSize, y: yRange.lowerLimit - 2*tileSize)))
        gameMap.addChild(self.newObject(name: "garbage", vector: &self.garbages, position: CGPoint(x: xRange.lowerLimit + 3*tileSize, y: yRange.lowerLimit - 2*tileSize)))
        
        // bins
        gameMap.addChild(self.newBin(color: "Blue", position: CGPoint(x: xRange.lowerLimit + 6*tileSize, y: yRange.lowerLimit + 7*tileSize)))
        gameMap.addChild(self.newBin(color: "Green", position: CGPoint(x: xRange.lowerLimit + tileSize, y: yRange.lowerLimit + 8*tileSize)))
        gameMap.addChild(self.newBin(color: "Red", position: CGPoint(x: xRange.lowerLimit + 3*tileSize, y: yRange.lowerLimit + 2*tileSize)))
        gameMap.addChild(self.newBin(color: "Yellow", position: CGPoint(x: xRange.lowerLimit + 8*tileSize, y: yRange.lowerLimit + 2*tileSize)))
        
        // player
        let player = SKSpriteNode(imageNamed: "playerFront")
        player.name = "player"
        player.position = CGPoint(x: xMiddle, y: yMiddle)
        player.zPosition = 2
        gameMap.addChild(player)
        
        // limit the players's movements according to the map
        player.constraints = [SKConstraint.positionX(xRange, y: yRange)]
        
        // add to the tree
        self.addChild(gameMap)
    }
    
    func newObject (name: String, vector: inout [SKSpriteNode], position: CGPoint) -> SKSpriteNode {
        let object = SKSpriteNode(imageNamed: name)
        object.position = position
        object.name = name
        
        if name == "garbage" {
            object.zPosition = 1
        } else {
            object.zPosition = 0
        }
        
        vector.append(object)
        
        return object
    }
    
    func newBin (color: String, position: CGPoint) -> SKSpriteNode {
        let bin = SKSpriteNode(imageNamed: "bin\(color)")
        
        bin.position = position
        bin.name = "bin"
        bin.zPosition = 0
        
        self.bins.append(bin)
        
        return bin
    }
    
    func createButton (imageNamed name: String, position: CGPoint) {
        let button = SKSpriteNode(imageNamed: name)
        button.name = name
        button.position = position
        
        self.addChild(button)
    }
    
}
