import SpriteKit

// screen size = 1024 x 768

// position of the buttons
let startButtonPos = CGPoint(x: 0, y: -64)
let restartButtonPos = CGPoint(x: 0, y: -64)

let arrowRightPos = CGPoint(x: 416, y: -160)
let arrowDownPos = CGPoint(x: 352, y: -224)
let arrowLeftPos = CGPoint(x: 288, y: -160)
let arrowUpPos = CGPoint(x: 352, y: -96)


func createLabel (text: String, position: CGPoint) -> SKLabelNode {
    let label = SKLabelNode(fontNamed: "PressStart2P-Regular")
    label.text = text
    label.fontSize = 18
    label.position = position
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    
    return label
}
