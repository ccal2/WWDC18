import PlaygroundSupport
import SpriteKit
import GameplayKit

public class GameScene: SKScene {
    
    public override func didMove (to view: SKView) {
        loadGameMap()
        
        createButton(imageNamed: "arrowLeft", position: CGPoint(x: (scene?.size.width)! * -0.4, y: (scene?.size.height)! * 0))
        createButton(imageNamed: "arrowDown", position: CGPoint(x: (scene?.size.width)! * -0.35, y: (scene?.size.height)! * -0.065))
        createButton(imageNamed: "arrowUp", position: CGPoint(x: (scene?.size.width)! * -0.35, y: (scene?.size.height)! * 0.065))
        createButton(imageNamed: "arrowRight", position: CGPoint(x: (scene?.size.width)! * -0.3, y: (scene?.size.height)! * 0))
    }
    
    func createPlayer () -> SKSpriteNode {
        let player = SKSpriteNode(imageNamed: "playerFront")
        player.name = "playerFront"
        player.position = CGPoint(x: (scene?.size.width)! * 0, y: (scene?.size.height)! * 0)

        return player
    }
    
    func createButton (imageNamed name: String, position: CGPoint) {
        let buttom = ButtonNode(imageNamed: name)
        buttom.position = position
        
        self.addChild(buttom)
    }
    
    func loadGameMap () {
        let gameMap = SKSpriteNode(imageNamed: "grassMap")
        gameMap.name = "gameMap"
        gameMap.position = CGPoint(x: (scene?.size.width)! * 0.08, y: (scene?.size.width)! * 0)
        
        gameMap.addChild(createPlayer())
        
        self.addChild(gameMap)
    }
    
}
