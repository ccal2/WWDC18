import SpriteKit

// screen size = 1024 x 768

// position of the buttons
let firstButtonPos = CGPoint(x: 0, y: -96)
let secondButtonPos = CGPoint(x: 0, y: -224)

let arrowRightPos = CGPoint(x: 416, y: -160)
let arrowDownPos = CGPoint(x: 352, y: -224)
let arrowLeftPos = CGPoint(x: 288, y: -160)
let arrowUpPos = CGPoint(x: 352, y: -96)

// functions

func createLabel (text: String, position: CGPoint, name: String = "", size: CGFloat = 18, maxWidth: CGFloat = 1000, alignmentH: SKLabelHorizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center) -> SKLabelNode {
    let label = SKLabelNode(fontNamed: "PressStart2P-Regular")
    label.text = text
    label.fontSize = size
    label.position = position
    label.horizontalAlignmentMode = alignmentH
    label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    label.zPosition = 1
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.numberOfLines = 0
    label.preferredMaxLayoutWidth = maxWidth
    
    if name == "" {
        label.name = text
    } else {
        label.name = name
    }
    
    return label
}

func createObject (folder: String = "", name: String, nodeName: String = "", position: CGPoint) -> SKSpriteNode {
    let object = SKSpriteNode(imageNamed: "\(folder)\(name)")
    object.position = position
    
    if nodeName == ""{
        object.name = name
    } else {
        object.name = nodeName
    }
    
    if name.prefix(7) == "garbage" {
        object.zPosition = 1
    } else {
        object.zPosition = 0
    }
    
    return object
}

func createPlayer (imageNamed name: String, position: CGPoint) -> SKSpriteNode {
    let player = SKSpriteNode(imageNamed: "Player/\(name)")
    player.name = "player"
    player.position = position
    player.zPosition = 2
    
    return player
}

func wait (_ seconds: Double) -> SKAction {
    return SKAction.moveBy(x: 0, y: 0, duration: seconds)
}

func moveRight (_ times: CGFloat) -> SKAction {
    return SKAction.moveBy(x: times*tileSize, y: 0, duration: TimeInterval(times))
}

func moveDown (_ times: CGFloat) -> SKAction {
    return SKAction.moveBy(x: 0, y: -times*tileSize, duration: TimeInterval(times))
}

func moveLeft (_ times: CGFloat) -> SKAction {
    return SKAction.moveBy(x: -times*tileSize, y: 0, duration: TimeInterval(times))
}

func moveUp (_ times: CGFloat) -> SKAction {
    return SKAction.moveBy(x: 0, y: times*tileSize, duration: TimeInterval(times))
}
