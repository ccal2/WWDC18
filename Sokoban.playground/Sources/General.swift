import SpriteKit

// screen size = 1024 x 768

// position of the buttons
let startButtonPos = CGPoint(x: 0, y: -96)
let restartButtonPos = CGPoint(x: 0, y: -96)

let arrowRightPos = CGPoint(x: 416, y: -160)
let arrowDownPos = CGPoint(x: 352, y: -224)
let arrowLeftPos = CGPoint(x: 288, y: -160)
let arrowUpPos = CGPoint(x: 352, y: -96)


func createLabel (text: String, position: CGPoint, size: CGFloat = 18, alignment: SKLabelHorizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center) -> SKLabelNode {
    let label = SKLabelNode(fontNamed: "PressStart2P-Regular")
    label.text = text
    label.fontSize = size
    label.position = position
    label.horizontalAlignmentMode = alignment
    
    return label
}

func createObject (folder: String = "", name: String, position: CGPoint) -> SKSpriteNode {
    let object = SKSpriteNode(imageNamed: "\(folder)\(name)")
    object.position = position
    object.name = name
    
    return object
}

func createPlayer (imageNamed name: String, position: CGPoint) -> SKSpriteNode {
    let player = SKSpriteNode(imageNamed: "Player/\(name)")
    player.name = "player"
    player.position = position
    player.zPosition = 2
    
    return player
}
