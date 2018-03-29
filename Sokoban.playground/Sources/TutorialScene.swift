import SpriteKit

public class TutorialScene: SKScene {
    public override func didMove (to view: SKView) {
        
    }
    
    func loadButtons () {
    }
    
    func touchButton (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        
        if button.name == "" {
            
        }
    }
    
    func Highlight (atPoint pos: CGPoint) {
        let button = self.atPoint(startButtonPos)
        
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
}
