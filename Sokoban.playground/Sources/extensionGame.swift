import PlaygroundSupport
import SpriteKit

let tileSize: CGFloat = 64

public class GameScene: SKScene {
    var trees: [SKSpriteNode] = []
    var garbageCans: [SKSpriteNode] = []
    var garbages: [SKSpriteNode] = []
    var columns = 10
    var lines = 5
    
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
        let player = self.childNode(withName: "gameMap")!.childNode(withName: "player")!
        
        let node = self.childNode(withName: "gameMap")!.atPoint(CGPoint(x: player.position.x + x, y: player.position.y + y))
        
        if node.name != "tree" && node.name != "garbageCan" {
            let move = SKAction.sequence([SKAction.moveBy(x: x, y: y, duration: 0.1)])
            
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
        gameMap.position = CGPoint(x: (scene?.size.width)! * 0.08, y: (scene?.size.width)! * 0)
        
        // gameMap limits and middle
        let width = gameMap.frame.width
        let height = gameMap.frame.height
        let xRange = SKRange(lowerLimit: (tileSize - width)/2, upperLimit: (width - tileSize)/2)
        let yRange = SKRange(lowerLimit: (tileSize - height)/2, upperLimit: (height - tileSize)/2)
        let xMiddle = xRange.lowerLimit + CGFloat(Int(columns/2)) * tileSize
        let yMiddle = yRange.lowerLimit + CGFloat(Int(lines/2)) * tileSize
        
        // trees
        for i in 0...(columns-1) {
            let j = CGFloat(i)
            gameMap.addChild(newObject(name: "tree", vector: &trees, position: CGPoint(x: (xRange.lowerLimit + j*tileSize), y: yRange.upperLimit)))
            gameMap.addChild(newObject(name: "tree", vector: &trees, position: CGPoint(x: (xRange.lowerLimit + j*tileSize), y: yRange.lowerLimit)))
        }
        
        for i in 1...(lines-2) {
            let j = CGFloat(i)
            gameMap.addChild(newObject(name: "tree", vector: &trees, position: CGPoint(x: xRange.upperLimit, y: (yRange.lowerLimit + j*tileSize))))
            gameMap.addChild(newObject(name: "tree", vector: &trees, position: CGPoint(x: xRange.lowerLimit, y: (yRange.lowerLimit + j*tileSize))))
        }
        
        // garbageCans
        gameMap.addChild(newObject(name: "garbageCan", vector: &garbageCans, position: CGPoint(x: xRange.upperLimit - tileSize, y: yRange.lowerLimit + tileSize)))
        gameMap.addChild(newObject(name: "garbageCan", vector: &garbageCans, position: CGPoint(x: xRange.lowerLimit + tileSize, y: yRange.upperLimit - tileSize)))
        
        // garbages
        gameMap.addChild(newObject(name: "garbage", vector: &garbages, position: CGPoint(x: xRange.lowerLimit + 5*tileSize, y: yRange.upperLimit - tileSize)))
        gameMap.addChild(newObject(name: "garbage", vector: &garbages, position: CGPoint(x: xRange.lowerLimit + 3*tileSize, y: yRange.upperLimit - 2*tileSize)))
        
        // player
        let player = SKSpriteNode(imageNamed: "playerFront")
        player.name = "player"
        player.position = CGPoint(x: xMiddle, y: yMiddle)
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
        
        vector.append(object)
        
        return object
    }
    
    func createButton (imageNamed name: String, position: CGPoint) {
        let button = SKSpriteNode(imageNamed: name)
        button.name = name
        button.position = position
        
        self.addChild(button)
    }
    
}
