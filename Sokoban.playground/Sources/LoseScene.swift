import SpriteKit

class LoseScene: SKScene {
    public override func didMove (to view: SKView) {
        self.addChild(createLabel(text: "Oh no! You've got trapped", position: CGPoint(x: 0, y: 96), size: 24))
        
        self.loadButton()
    }
    
    func loadButton () {
        let restartButton = createObject(name: "button", nodeName: "Restart", position: firstButtonPos)
        let homeButton = createObject(name: "button", nodeName: "Home", position: secondButtonPos)
        
        self.addChild(restartButton)
        self.addChild(homeButton)
        
        restartButton.addChild(createLabel(text: "Restart", position: CGPoint(x: 0, y: -10)))
        homeButton.addChild(createLabel(text: "Home", position: CGPoint(x: 0, y: -10)))
    }
    
    func touchButton (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        
        if button.name == "Restart" {
            self.addChild(createObject(name: "button_h", position: firstButtonPos))
            
            let scene = GameScene(fileNamed: "Scene")!
            scene.backgroundColor = #colorLiteral(red: 0.7093039155, green: 0.2193932235, blue: 0.3572371602, alpha: 1)
            scene.scaleMode = .aspectFill
            
            let transition = SKTransition.fade(with: #colorLiteral(red: 0.645771694, green: 0.2032078091, blue: 0.3298983863, alpha: 1), duration: 1)
            
            self.view?.presentScene(scene, transition: transition)
        } else if button.name == "Home" {
            self.addChild(createObject(name: "button_h", position: secondButtonPos))
            
            let scene = InitialScene(fileNamed: "Scene")!
            scene.backgroundColor = #colorLiteral(red: 0.7093039155, green: 0.2193932235, blue: 0.3572371602, alpha: 1)
            scene.scaleMode = .aspectFill
            
            let transition = SKTransition.fade(with: #colorLiteral(red: 0.645771694, green: 0.2032078091, blue: 0.3298983863, alpha: 1), duration: 1)
            
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
    func Highlight (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        
        if button.name == "button_h" {
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

