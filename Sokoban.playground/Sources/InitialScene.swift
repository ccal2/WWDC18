import SpriteKit

public class InitialScene: SKScene {
    public override func didMove (to view: SKView) {
        self.showAnimation()
        self.loadButtons()
    }
    
    func loadButtons () {
        let playButton = createObject(name: "button", nodeName: "Play", position: firstButtonPos)
        let tutorialButton = createObject(name: "button", nodeName: "Tutorial", position: secondButtonPos)
        
        self.addChild(playButton)
        self.addChild(tutorialButton)
        
        playButton.addChild(createLabel(text: "Play", position: CGPoint(x: 0, y: -10)))
        tutorialButton.addChild(createLabel(text: "Tutorial", position: CGPoint(x: 0, y: -10)))
    }
    
    func showAnimation () {
//        // add player
//        let player = createPlayer(imageNamed: "playerFront", position: CGPoint(x: -160, y: 160))
//        self.addChild(player)
        
        // add player
        let playerFront = createObject(folder: "Player/", name: "playerFront", position: CGPoint(x: -160, y: 160))
        self.addChild(playerFront)
        
        let playerRight = createObject(folder: "Player/", name: "playerRight", position: CGPoint(x: -160, y: 160))
        playerRight.isHidden = true
        self.addChild(playerRight)
        
        // add garbage
        let garbage = createObject(folder: "Garbages/", name: "garbageBlue", position: CGPoint(x: -32, y: 160))
        garbage.zPosition = 1
        self.addChild(garbage)
        
        // add bin
        self.addChild(createObject(folder: "Bins/", name: "binBlue", position: CGPoint(x: 160, y: 160)))
        
        // actions
        let actionPlayerFront = SKAction.sequence([SKAction.move(to: CGPoint(x: -160, y: 160), duration: 0), SKAction.unhide(), wait(1), SKAction.hide(), wait(5.5)])
        let actionPlayerRight = SKAction.sequence([SKAction.move(to: CGPoint(x: -160, y: 160), duration: 0), wait(1), SKAction.unhide(), moveRight(4), wait(1.5), SKAction.hide()])
        let actionGarbage = SKAction.sequence([SKAction.move(to: CGPoint(x: -32, y: 160), duration: 0), SKAction.unhide(), wait(2), moveRight(3), wait(0.5), SKAction.hide(), wait(1)])
        
        // run actions
        playerFront.run(SKAction.repeatForever(actionPlayerFront))
        playerRight.run(SKAction.repeatForever(actionPlayerRight))
        garbage.run(SKAction.repeatForever(actionGarbage))
    }
    
    func touchButton (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        
        if button.name == "Play" {
            self.addChild(createObject(name: "button_h", position: firstButtonPos))
            
            let scene = GameScene(fileNamed: "Scene")!
            scene.backgroundColor = #colorLiteral(red: 0.7093039155, green: 0.2193932235, blue: 0.3572371602, alpha: 1)
            scene.scaleMode = .aspectFill
            
            let transition = SKTransition.fade(with: #colorLiteral(red: 0.645771694, green: 0.2032078091, blue: 0.3298983863, alpha: 1), duration: 1)
            
            self.view?.presentScene(scene, transition: transition)
        } else if button.name == "Tutorial" {
            self.addChild(createObject(name: "button_h", position: secondButtonPos))
            
            let scene = TutorialScene(fileNamed: "Scene")!
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

