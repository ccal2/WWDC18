import PlaygroundSupport
import SpriteKit

class WinScene: SKScene {
    public override func didMove (to view: SKView) {
        createButton(imageNamed: "temp", position: restartButtonPos)
    }
    
    func touchButton (atPoint pos: CGPoint) {
        // highlight
        self.createButton(imageNamed: "temp_h", position: restartButtonPos)
        
        let scene = GameScene(fileNamed: "Scene")!
        scene.backgroundColor = #colorLiteral(red: 0.7093039155, green: 0.2193932235, blue: 0.3572371602, alpha: 1)
        scene.scaleMode = .aspectFill
        
        // delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.presentScene(scene)
        }
    }
    
    func Highlight (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        
        if button.name == "temp_h" {
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
            Highlight(atPoint: t.location(in: self))
        }
    }
    
    func createButton (imageNamed name: String, position: CGPoint) {
        let button = SKSpriteNode(imageNamed: name)
        button.name = name
        button.position = position
        
        self.addChild(button)
    }
}
