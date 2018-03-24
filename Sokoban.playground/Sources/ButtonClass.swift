import SpriteKit

public class ButtonNode: SKSpriteNode {
    
    func touchDown(atPoint pos : CGPoint) {
        print("touch down")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        print("touch moved")
    }
    
    func touchUp(atPoint pos : CGPoint) {
        print("touch up")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchDown(atPoint: t.location(in: self))
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchMoved(toPoint: t.location(in: self))
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchUp(atPoint: t.location(in: self))
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchUp(atPoint: t.location(in: self))
        }
    }
    
}
