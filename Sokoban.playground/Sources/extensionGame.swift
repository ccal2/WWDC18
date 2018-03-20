import PlaygroundSupport
import SpriteKit

public class GameScene: SKScene {
    
    public override func didMove (to view: SKView) {
        let leftArrow = ButtonNode(imageNamed: "leftArrow")
        leftArrow.position = CGPoint(x: (scene?.size.width)! * -0.3, y: (scene?.size.height)! * 0)
        
        let downArrow = ButtonNode(imageNamed: "downArrow")
        downArrow.position = CGPoint(x: (scene?.size.width)! * -0.25, y: (scene?.size.height)! * 0)
        
        let upArrow = ButtonNode(imageNamed: "upArrow")
        upArrow.position = CGPoint(x: (scene?.size.width)! * -0.25, y: (scene?.size.height)! * 0.065)
        
        let rightArrow = ButtonNode(imageNamed: "rightArrow")
        rightArrow.position = CGPoint(x: (scene?.size.width)! * -0.2, y: (scene?.size.height)! * 0)
    }
    
    func createCircle (){
        let circle = SKShapeNode(circleOfRadius: 100)
        circle.name = "circle"
        //circle.position = CGPoint(x: (scene?.size.width)! * 0, y: (scene?.size.height)! * 0)
        circle.position = CGPoint(x: 0, y: 0)
        circle.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        circle.glowWidth = 1.0
        //circle.fillColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.addChild(circle)
    }
    
    func createPlayer () {
        let player = SKSpriteNode(imageNamed: "player")
        player.name = "player"
        player.position = CGPoint(x: (scene?.size.width)! * 0, y: (scene?.size.height)! * 0)
//        player.xScale = 0.5
//        player.yScale = 0.5

        self.addChild(player)
    }
    
    func createButton (position: CGPoint, text: String) {
        let button = SKShapeNode(circleOfRadius: 20)
        button.name = "button_" + text
        button.position = position
        button.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        let label = SKLabelNode(text: text)
        label.name = text
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        //label.position = CGPoint(x: 0, y: button.frame.height * -0.25)
        label.fontColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        button.addChild(label)
        
        self.addChild(button)
        //self.addChild(label)
    }
    
    
    
}
