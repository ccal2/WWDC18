import SpriteKit

// buttons' positions
let homeButtonPos = CGPoint(x: 352, y: -229)
let nextButtonPos = CGPoint(x: 352, y: -101)
let instructionBlockPos = CGPoint(x: 352, y: 133)

// constants
let numberOfSteps = 2

// instructions
let instruction0 = createLabel(text: "Move the garbages to the bins", position: CGPoint.zero, name: "instruction0", maxWidth: 192)
let instruction1 = createLabel(text: "You can't move a garbage of a type to a bin of a different type!", position: CGPoint.zero, name: "instruction1", maxWidth: 192)
let instruction2 = createLabel(text: "So be sure to move it to the right bin", position: CGPoint.zero, name: "instruction2", maxWidth: 192)
let instruction3 = createLabel(text: "Be carefull not to trap your garbage!", position: CGPoint.zero, name: "instruction3", maxWidth: 192)
let instructions: [SKLabelNode] = [instruction0, instruction1, instruction2, instruction3]

class TutorialScene: SKScene {
    var instruction = 0

    public override func didMove (to view: SKView) {
        self.loadButtons()
        self.loadGameMap()
        self.loadInstructionBlock()
        self.instructionsAnimation(0)
    }
    
    func instructionsAnimation (_ number: Int) {
        let gameMap = self.childNode(withName: "gameMap")!
        
        // get players
        let playerFront = gameMap.childNode(withName: "playerFront")!
        let playerRight = gameMap.childNode(withName: "playerRight")!
        let playerBack = gameMap.childNode(withName: "playerBack")!
        let playerLeft = gameMap.childNode(withName: "playerLeft")!
        
        // get garbages
        let garbageBlue = gameMap.childNode(withName: "garbageBlue")!
        let garbageYellow = gameMap.childNode(withName: "garbageYellow")!
        
        // display instruction (text)
        let block = self.childNode(withName: "block")!
        for i in 0...3 {
            let instruction = block.childNode(withName: "instruction\(i)")!
            
            if i == number {
                instruction.isHidden = false
            } else {
                instruction.isHidden = true
            }
        }
        
        // stop previous animation
        playerFront.removeAllActions()
        playerRight.removeAllActions()
        playerBack.removeAllActions()
        playerLeft.removeAllActions()
        garbageBlue.removeAllActions()
        garbageYellow.removeAllActions()
        
        // run animation
        playerFront.run(actionsPlayerFront(number))
        playerRight.run(actionsPlayerRight(number))
        playerBack.run(actionsPlayerBack(number))
        playerLeft.run(actionsPlayerLeft(number))
        garbageBlue.run(actionsGarbageBlue(number))
        garbageYellow.run(actionsGarbageYellow(number))
    }
    
    func actionsPlayerFront (_ number: Int) -> SKAction {
        var action = wait(0)
        
        switch number {
        case 0:
            action = SKAction.sequence([SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), SKAction.unhide(), wait(1), SKAction.hide(), wait(4.5)]) // 1
        case 1:
            action = SKAction.sequence([SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), SKAction.unhide(), wait(1), SKAction.hide(), wait(3)]) // 1
        case 2:
            action = SKAction.sequence([SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), SKAction.unhide(), wait(1), moveDown(1), wait(1), SKAction.hide(), wait(14.5)]) // 3
        case 3:
            action = SKAction.sequence([SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), SKAction.unhide(), wait(1), SKAction.hide(), moveRight(1), wait(1), SKAction.unhide(), wait(1), moveDown(1), wait(1), SKAction.hide(), wait(7)]) // 6
        default:
            print("invalid number")
        }
        
        return action
    }
    
    func actionsPlayerRight (_ number: Int) -> SKAction {
        var action = wait(0)
        
        switch number {
        case 0:
            action = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), wait(1), SKAction.unhide(), moveRight(3), wait(1.5)]) // 4
        case 1:
            action = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), wait(1), SKAction.unhide(), moveRight(2), wait(1)]) // 3
        case 2:
            action = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 4, y: 4, xRange, yRange), duration: 0), wait(3), SKAction.unhide(), wait(1), moveRight(1), wait(1), SKAction.hide(), moveUp(2), moveLeft(1), wait(5), SKAction.unhide(), wait(1), moveRight(1), wait(1.5)]) // 16
        case 3:
            action = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), wait(1), SKAction.unhide(), moveRight(1), wait(1), SKAction.hide(), moveDown(1), wait(2), SKAction.unhide(), wait(1), moveRight(1), wait(1), SKAction.hide(), wait(4)]) // 9
        default:
            print("invalid number")
        }
        
        return action
    }
    
    func actionsPlayerBack (_ number: Int) -> SKAction {
        var action = wait(0)
        
        switch number {
        case 0:
            action = SKAction.sequence([SKAction.hide(), wait(5.5)]) // 0
        case 1:
            action = SKAction.sequence([SKAction.hide(), wait(4)]) // 0
        case 2:
            action = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 5, y: 4, xRange, yRange), duration: 0), wait(6), SKAction.unhide(), wait(1), moveUp(1), wait(1), SKAction.hide(), moveLeft(1), wait(2), SKAction.unhide(), wait(1), moveUp(1), wait(1), SKAction.hide(), wait(2.5)]) // 15
        case 3:
            action = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 4, y: 4, xRange, yRange), duration: 0), wait(9), SKAction.unhide(), wait(1), moveUp(2), wait(1)]) // 12
        default:
            print("invalid number")
        }
        
        return action
    }
    
    func actionsPlayerLeft (_ number: Int) -> SKAction {
        var action = wait(0)
        
        switch number {
        case 0:
            action = SKAction.sequence([SKAction.hide(), wait(5.5)]) // 0
        case 1:
            action = SKAction.sequence([SKAction.hide(), wait(4)]) // 0
        case 2:
            action = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 5, y: 3, xRange, yRange), duration: 0), wait(9), SKAction.unhide(), wait(1), moveLeft(1), wait(1), SKAction.hide(), wait(5.5)]) // 12
        case 3:
            action = SKAction.sequence([SKAction.hide(), wait(13)]) // 0
        default:
            print("invalid number")
        }
        
        return action
    }
    
    func actionsGarbageBlue (_ number: Int) -> SKAction {
        var action = wait(0)
        
        switch number {
        case 0:
            action = SKAction.sequence([SKAction.unhide(), SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), wait(2), moveRight(2), wait(0.5), SKAction.hide(), wait(1)]) // 4.5
        case 1:
            action = SKAction.sequence([SKAction.hide(), wait(4)]) // 0
        case 2:
            action = SKAction.sequence([SKAction.hide(), wait(17.5)]) // 0
        case 3:
            action = SKAction.sequence([SKAction.hide(), wait(13)]) // 0
        default:
            print("invalid number")
        }
        
        return action
    }
    
    func actionsGarbageYellow (_ number: Int) -> SKAction {
        var action = wait(0)
        
        switch number {
        case 0:
            action = SKAction.sequence([SKAction.hide(), wait(5.5)]) // 0
        case 1:
            action = SKAction.sequence([SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), SKAction.unhide(), wait(2), moveRight(1), wait(1)]) // 3
        case 2:
            action = SKAction.sequence([SKAction.move(to: self.matrix(x: 5, y: 3, xRange, yRange), duration: 0), SKAction.unhide(), wait(7), moveUp(1), wait(7), moveRight(1), wait(0.5), SKAction.hide(), wait(1)]) // 16.5
        case 3:
            action = SKAction.sequence([SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), SKAction.unhide(), wait(10), moveUp(2), wait(1)]) // 12
        default:
            print("invalid number")
        }
        
        return action
    }
    
    func touchButton (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        
        if button.name == "Home" {
            self.addChild(createObject(name: "button_h", position: homeButtonPos))
            
            let scene = InitialScene(size: sceneSize)
            scene.backgroundColor = #colorLiteral(red: 0.7093039155, green: 0.2193932235, blue: 0.3572371602, alpha: 1)
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            scene.scaleMode = .aspectFill
            
            let transition = SKTransition.fade(with: #colorLiteral(red: 0.645771694, green: 0.2032078091, blue: 0.3298983863, alpha: 1), duration: 1)
            
            self.view?.presentScene(scene, transition: transition)
        } else if button.name == "Next" {
            self.addChild(createObject(name: "button_h", position: nextButtonPos))
            
            self.instruction = (self.instruction + 1) % 4
            self.instructionsAnimation(self.instruction)
        }
    }
    
    func Highlight (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        
        if button.name == "button_h" {
            button.removeFromParent()
        }
    }
    
    func loadButtons () {
        let homeButton = createObject(name: "button", nodeName: "Home", position: homeButtonPos)
        let nextButton = createObject(name: "button", nodeName: "Next", position: nextButtonPos)
        
        self.addChild(homeButton)
        self.addChild(nextButton)
        
        homeButton.addChild(createLabel(text: "Home", position: CGPoint.zero))
        nextButton.addChild(createLabel(text: "Next", position: CGPoint.zero))
    }
    
    func loadGameMap () {
        // grass background
        let gameMap = SKSpriteNode(imageNamed: "grassMap")
        gameMap.name = "gameMap"
        gameMap.position = CGPoint(x: -128, y: 0)
        
        // gameMap limits
        let width = gameMap.frame.width - 10 // 10 -> grassMap margins
        let height = gameMap.frame.height - 10
        let xRange = SKRange(lowerLimit: (tileSize - width)/2, upperLimit: (width - tileSize)/2)
        let yRange = SKRange(lowerLimit: (tileSize - height)/2, upperLimit: (height - tileSize)/2)
       
        // trees
        for i in 0...(Int(columns)-1) {
            let j = CGFloat(i)
            gameMap.addChild(createObject(name: "tree", position: self.matrix(x: j, y: 0, xRange, yRange)))
            gameMap.addChild(createObject(name: "tree", position: self.matrix(x: j, y: lines-1, xRange, yRange)))
        }
        
        for i in 1...(Int(lines)-2) {
            let j = CGFloat(i)
            gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 0, y: j, xRange, yRange)))
            gameMap.addChild(createObject(name: "tree", position: self.matrix(x: columns-1, y: j, xRange, yRange)))
        }
        
        gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 8, y: 6, xRange, yRange)))
        gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 1, y: 5, xRange, yRange)))
        gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 2, y: 5, xRange, yRange)))
        gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 4, y: 5, xRange, yRange)))
        gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 8, y: 4, xRange, yRange)))
        gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 1, y: 3, xRange, yRange)))
        gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 5, y: 1, xRange, yRange)))
        
        // bins
        gameMap.addChild(createObject(folder: "Bins/", name: "binBlue", position: self.matrix(x: 6, y: 3, xRange, yRange)))
        gameMap.addChild(createObject(folder: "Bins/", name: "binYellow", position: self.matrix(x: 6, y: 2, xRange, yRange)))
        
        // garbages
        let garbageBlue = createObject(folder: "Garbages/", name: "garbageBlue", position: self.matrix(x: 4, y: 3, xRange, yRange))
        gameMap.addChild(garbageBlue)
        let garbageYellow = createObject(folder: "Garbages/", name: "garbageYellow", position: self.matrix(x: 4, y: 3, xRange, yRange))
        garbageYellow.isHidden = true
        gameMap.addChild(garbageYellow)
        
        // players
        let playerFront = createObject(folder: "Player/", name: "playerFront", position: self.matrix(x: 2, y: 3, xRange, yRange))
        gameMap.addChild(playerFront)
        let playerRight = createObject(folder: "Player/", name: "playerRight", position: self.matrix(x: 2, y: 3, xRange, yRange))
        playerRight.isHidden = true
        gameMap.addChild(playerRight)
        let playerBack = createObject(folder: "Player/", name: "playerBack", position: self.matrix(x: 2, y: 3, xRange, yRange))
        playerBack.isHidden = true
        gameMap.addChild(playerBack)
        let playerLeft = createObject(folder: "Player/", name: "playerLeft", position: self.matrix(x: 2, y: 3, xRange, yRange))
        playerLeft.isHidden = true
        gameMap.addChild(playerLeft)
        
        self.addChild(gameMap)
    }
    
    func loadInstructionBlock () {
        // block
        let block = SKSpriteNode(imageNamed: "block")
        block.name = "block"
        block.position = instructionBlockPos
        
        self.addChild(block)
        
        // instructions (text)
        for instruction in instructions {
            instruction.isHidden = true
            block.addChild(instruction)
        }
    }
    
    // convert position
    func matrix (x posX: CGFloat, y posY: CGFloat, _ xRange: SKRange, _ yRange: SKRange) -> CGPoint {
        return CGPoint(x: xRange.lowerLimit + posX*tileSize, y: yRange.lowerLimit + (lines-1 - posY)*tileSize)
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


//// animations
//// 0 - move the garbage to the bin
//    //      > > > > .
//    let actionPlayerFront0 = SKAction.sequence([SKAction.unhide(), wait(1), SKAction.hide(), wait(4.5)]) // 1
//    let actionPlayerRight0 = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), wait(1), SKAction.unhide(), moveRight(3), wait(1.5)]) // 4
//    let actionPlayerBack0 = SKAction.sequence([SKAction.hide(), wait(5.5)]) // 0
//    let actionPlayerLeft0 = SKAction.sequence([SKAction.hide(), wait(5.5)]) // 0
//    let actionGarbageBlue0 = SKAction.sequence([SKAction.unhide(), SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), wait(2), moveRight(2), wait(0.5), SKAction.hide(), wait(1)]) // 4.5
//    let actionGarbageYellow0 = SKAction.sequence([SKAction.hide(), wait(5.5)]) // 0
//
//// 1.1 - be sure to move it to the right bin
//    //      > > > .
//    let actionPlayerFront11 = SKAction.sequence([SKAction.unhide(), wait(1), SKAction.hide(), wait(3)]) // 1
//    let actionPlayerRight11 = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), wait(1), SKAction.unhide(), moveRight(2), wait(1)]) // 3
//    let actionPlayerBack11 = SKAction.sequence([SKAction.hide(), wait(4)]) // 0
//    let actionPlayerLeft11 = SKAction.sequence([SKAction.hide(), wait(4)]) // 0
//    let actionGarbageBlue11 = SKAction.sequence([SKAction.hide(), wait(4)]) // 0
//    let actionGarbageYellow11 = SKAction.sequence([SKAction.unhide(), SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), wait(2), moveRight(1), wait(1)]) // 3
//
//// 1.2 - be sure to move it to the right bin
//    //      V > ^ < ^ > .
//    let actionPlayerFront12 = SKAction.sequence([SKAction.unhide(), SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), wait(1), moveDown(1), wait(1), SKAction.hide(), wait(14.5)]) // 3
//    let actionPlayerRight12 = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 4, y: 4, xRange, yRange), duration: 0), wait(3), SKAction.unhide(), wait(1), moveRight(1), wait(1), SKAction.hide(), moveUp(2), moveLeft(1), wait(5), SKAction.unhide(), wait(1), moveRight(1), wait(1.5)]) // 16
//    let actionPlayerBack12 = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 5, y: 4, xRange, yRange), duration: 0), wait(6), SKAction.unhide(), wait(1), moveUp(1), wait(1), SKAction.hide(), moveLeft(1), wait(2), SKAction.unhide(), wait(1), moveUp(1), wait(1), SKAction.hide(), wait(2.5)]) // 15
//    let actionPlayerLeft12 = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 5, y: 3, xRange, yRange), duration: 0), wait(9), SKAction.unhide(), wait(1), moveLeft(1), wait(1), SKAction.hide(), wait(5.5)]) // 12
//    let actionGarbageBlue12 = SKAction.sequence([SKAction.hide(), wait(17.5)]) // 0
//    let actionGarbageYellow12 = SKAction.sequence([SKAction.unhide(), wait(7), moveUp(1), wait(7), moveRight(1), wait(0.5), SKAction.hide(), wait(1)]) // 16.5
//
//// 2 - don't get trapped
//    //      > V > ^ ^ .
//    let actionPlayerFront2 = SKAction.sequence([SKAction.unhide(), SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), wait(1), SKAction.hide(), moveRight(1), wait(1), SKAction.unhide(), wait(1), moveDown(1), wait(1), SKAction.hide(), wait(7)]) // 6
//    let actionPlayerRight2 = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), wait(1), SKAction.unhide(), moveRight(1), wait(1), SKAction.hide(), moveDown(1), wait(2), SKAction.unhide(), wait(1), moveRight(1), wait(1), SKAction.hide(), wait(4)]) // 9
//    let actionPlayerBack2 = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 4, y: 4, xRange, yRange), duration: 0), wait(9), SKAction.unhide(), wait(1), moveUp(2), wait(1)]) // 12
//    let actionPlayerLeft2 = SKAction.sequence([SKAction.hide(), wait(13)]) // 0
//    let actionGarbageBlue2 = SKAction.sequence([SKAction.hide(), wait(13)]) // 0
//    let actionGarbageYellow2 = SKAction.sequence([SKAction.unhide(), SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), wait(10), moveUp(2), wait(1)]) // 12

