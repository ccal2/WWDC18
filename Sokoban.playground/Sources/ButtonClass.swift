import SpriteKit

class ButtonNode: SKSpriteNode {
    //var label: SKLabelNode
    
    func touchDown(atPoint pos : CGPoint) {
        print("touch down")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        print("touch moved")
    }
    
    func touchUp(atPoint pos : CGPoint) {
        print("touch up")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchMoved(toPoint: t.location(in: self))
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchUp(atPoint: t.location(in: self))
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchUp(atPoint: t.location(in: self))
            
        }
    }
    
    
}
