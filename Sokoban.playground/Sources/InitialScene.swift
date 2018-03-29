import PlaygroundSupport
import SpriteKit

public class InitialScene: SKScene {
    public override func didMove (to view: SKView) {
        //self.addChild(createLabel(text: "Name of the game", position: CGPoint(x: 0, y: 96), size: 24))
        self.showAnimation()
        
        self.addChild(createObject(name: "temp", position: startButtonPos))
    }
    
    func showAnimation () {
        // add player
        let player = createPlayer(imageNamed: "playerFront", position: CGPoint(x: -160, y: 96))
        self.addChild(player)
        
        // add garbage
        let garbage = createObject(folder: "Garbages/", name: "garbageBlue", position: CGPoint(x: -32, y: 96))
        garbage.zPosition = 1
        self.addChild(garbage)
        
        // add bin
        self.addChild(createObject(folder: "Bins/", name: "binBlue", position: CGPoint(x: 160, y: 96)))
        
        let actionPlayer = SKAction.sequence([SKAction.moveBy(x: 256, y: 0, duration: 3), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.moveBy(x: -256, y: 0, duration: 0), SKAction.moveBy(x: 0, y: 0, duration: 1)])
        let actionBargage = SKAction.sequence([SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.moveBy(x: 192, y: 0, duration: 2), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.unhide(), SKAction.moveBy(x: -192, y: 0, duration: 0), SKAction.moveBy(x: 0, y: 0, duration: 1)])
        
        let repeatActionPlayer = SKAction.repeatForever(actionPlayer)
        let repeatActionGarbage = SKAction.repeatForever(actionBargage)
        
        player.run(repeatActionPlayer)
        garbage.run(repeatActionGarbage)
    }
    
    func touchButton (atPoint pos: CGPoint) {
        // highlight
        self.addChild(createObject(name: "temp_h", position: startButtonPos))
        
        let scene = GameScene(fileNamed: "Scene")!
        scene.backgroundColor = #colorLiteral(red: 0.7093039155, green: 0.2193932235, blue: 0.3572371602, alpha: 1)
        scene.scaleMode = .aspectFill

        let transition = SKTransition.fade(with: #colorLiteral(red: 0.645771694, green: 0.2032078091, blue: 0.3298983863, alpha: 1), duration: 1)
        
        self.view?.presentScene(scene, transition: transition)
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

