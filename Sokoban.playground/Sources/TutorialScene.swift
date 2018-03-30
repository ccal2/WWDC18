import SpriteKit

// button position
let homeButtonPos = CGPoint(x: 352, y: -224)

// constant
let numberOfSteps = 2

class TutorialScene: SKScene {
    public override func didMove (to view: SKView) {
        self.loadButtons()
        self.loadGameMap()
        self.instructionsAnimation()
    }
    
    func instructionsAnimation () {
        let gameMap = self.childNode(withName: "gameMap")!
        
        // gameMap limits
        let width = gameMap.frame.width - 10 // 10 -> grassMap margins
        let height = gameMap.frame.height - 10
        let xRange = SKRange(lowerLimit: (tileSize - width)/2, upperLimit: (width - tileSize)/2)
        let yRange = SKRange(lowerLimit: (tileSize - height)/2, upperLimit: (height - tileSize)/2)
        
        // add players
            // front
            let playerFront = createObject(folder: "Player/", name: "playerFront", position: self.matrix(x: 2, y: 3, xRange, yRange))
            gameMap.addChild(playerFront)
            // right
            let playerRight = createObject(folder: "Player/", name: "playerRight", position: self.matrix(x: 2, y: 3, xRange, yRange))
            playerRight.isHidden = true
            gameMap.addChild(playerRight)
            // back
            let playerBack = createObject(folder: "Player/", name: "playerBack", position: self.matrix(x: 3, y: 3, xRange, yRange))
            playerBack.isHidden = true
            gameMap.addChild(playerBack)
            // left
            let playerLeft = createObject(folder: "Player/", name: "playerLeft", position: self.matrix(x: 3, y: 3, xRange, yRange))
            playerLeft.isHidden = true
            gameMap.addChild(playerLeft)
        
        // add garbages
        let garbageBlue = createObject(folder: "Garbages/", name: "garbageBlue", position: self.matrix(x: 4, y: 3, xRange, yRange))
        gameMap.addChild(garbageBlue)
        let garbageYellow = createObject(folder: "Garbages/", name: "garbageYellow", position: self.matrix(x: 4, y: 3, xRange, yRange))
        garbageYellow.isHidden = true
        gameMap.addChild(garbageYellow)
        
        // animations
        // 0 - move the garbage to the bin
            // instruction
                // text
        
            // actions
                //      > > > >
            let actionPlayerFront0 = SKAction.sequence([SKAction.unhide(), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 4.5)])
            let actionPlayerRight0 = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.unhide(), SKAction.moveBy(x: tileSize*3, y: 0, duration: 3), SKAction.moveBy(x: 0, y: 0, duration: 1.5), SKAction.hide()])
            let actionPlayerBack0 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 5.5)])
            let actionPlayerLeft0 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 5.5)])
            let actionGarbageBlue0 = SKAction.sequence([SKAction.unhide(), SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), SKAction.moveBy(x: 0, y: 0, duration: 2), SKAction.moveBy(x: tileSize*2, y: 0, duration: 2), SKAction.moveBy(x: 0, y: 0, duration: 0.5), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 1)])
            let actionGarbageYellow0 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 5.5)])
        
        // 1.1 - be sure to move it to the right bin
            // instruction
                // text
        
            // actions
                //      > V > ^ < ^ > > .
            let actionPlayerFront11 = SKAction.sequence([SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), SKAction.unhide(), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.unhide(), SKAction.moveBy(x: 0, y: 0, duration: 0), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 6.5)])
            let actionPlayerRight11 = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.unhide(), SKAction.moveBy(x: tileSize, y: 0, duration: 1), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 1.5), SKAction.hide()])
            let actionPlayerBack11 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 2), SKAction.unhide(), SKAction.moveBy(x: 0, y: -tileSize, duration: 1), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.hide(), SKAction.unhide(), SKAction.moveBy(x: 0, y: 0, duration: 0)])
            let actionPlayerLeft11 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 7.5)])
            let actionGarbageBlue11 = SKAction.sequence([SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), SKAction.unhide(), SKAction.moveBy(x: 0, y: 0, duration:  2), SKAction.moveBy(x: tileSize*2, y: 0, duration: 2), SKAction.moveBy(x: 0, y: 0, duration: 0.5), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 1)])
            let actionGarbageYellow11 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 7.5)])
        
        // 1.2 - be sure to move it to the right bin
            // instruction
                // text
        
            // actions
            let actionPlayerFront12 = SKAction.sequence([SKAction.unhide(), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 4.5)])
            let actionPlayerRight12 = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.unhide(), SKAction.moveBy(x: tileSize*3, y: 0, duration: 3), SKAction.moveBy(x: 0, y: 0, duration: 1.5), SKAction.hide()])
            let actionPlayerBack12 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 5.5)])
            let actionPlayerLeft12 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 5.5)])
            let actionGarbageBlue12 = SKAction.sequence([SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), SKAction.unhide(), SKAction.moveBy(x: 0, y: 0, duration: 2), SKAction.moveBy(x: tileSize*2, y: 0, duration: 2), SKAction.moveBy(x: 0, y: 0, duration: 0.5), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 1)])
            let actionGarbageYellow12 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 5.5)])
        
        // 2 - don't get trapped
            // instruction
                // text
        
            // actions
            let actionPlayerFront2 = SKAction.sequence([SKAction.unhide(), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 4.5)])
            let actionPlayerRight2 = SKAction.sequence([SKAction.hide(), SKAction.move(to: self.matrix(x: 2, y: 3, xRange, yRange), duration: 0), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.unhide(), SKAction.moveBy(x: tileSize*3, y: 0, duration: 3), SKAction.moveBy(x: 0, y: 0, duration: 1.5)])
            let actionPlayerBack2 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 5.5)])
            let actionPlayerLeft2 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 5.5)])
            let actionGarbageBlue2 = SKAction.sequence([SKAction.unhide(), SKAction.move(to: self.matrix(x: 4, y: 3, xRange, yRange), duration: 0), SKAction.moveBy(x: 0, y: 0, duration: 2), SKAction.moveBy(x: tileSize*2, y: 0, duration: 2), SKAction.moveBy(x: 0, y: 0, duration: 0.5), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 1)])
            let actionGarbageYellow2 = SKAction.sequence([SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 5.5)])
        
        // put it together
        let actionPlayerFront = SKAction.sequence([actionPlayerFront0, actionPlayerFront11, actionPlayerFront12, actionPlayerFront2])
        let actionPlayerRight = SKAction.sequence([actionPlayerRight0, actionPlayerRight11, actionPlayerRight12, actionPlayerRight2])
        let actionPlayerBack = SKAction.sequence([actionPlayerBack0, actionPlayerBack11, actionPlayerBack12, actionPlayerBack2])
        let actionPlayerLeft = SKAction.sequence([actionPlayerLeft0, actionPlayerLeft11, actionPlayerLeft12, actionPlayerLeft2])
        let actionGarbageBlue = SKAction.sequence([actionGarbageBlue0, actionGarbageBlue11, actionGarbageBlue12, actionGarbageBlue2])
        let actionGarbageYellow = SKAction.sequence([actionGarbageYellow0, actionGarbageYellow11, actionGarbageYellow12, actionGarbageYellow2])
        
        // run actions
        playerFront.run(actionPlayerFront)
        playerRight.run(actionPlayerRight)
        playerBack.run(actionPlayerBack)
        playerLeft.run(actionPlayerLeft)
        garbageBlue.run(actionGarbageBlue)
        garbageYellow.run(actionGarbageYellow)
    }
    
    func touchButton (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        
        if button.name == "Home" {
            self.addChild(createObject(name: "button_h", position: homeButtonPos))
            
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
        } else if button.name == "arrowLeft_h" || button.name == "arrowRight_h" || button.name == "arrowUp_h" || button.name == "arrowDown_h" {
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
    
    func loadButtons () {
        let homeButton = createObject(name: "button", nodeName: "Home", position: homeButtonPos)
        self.addChild(homeButton)
        homeButton.addChild(createLabel(text: "Home", position: CGPoint(x: 0, y: -10)))
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
        gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 5, y: 5, xRange, yRange)))
        gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 8, y: 4, xRange, yRange)))
        gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 1, y: 3, xRange, yRange)))
        gameMap.addChild(createObject(name: "tree", position: self.matrix(x: 5, y: 1, xRange, yRange)))
        
        // bins
        gameMap.addChild(createObject(folder: "Bins/", name: "binBlue", position: self.matrix(x: 6, y: 3, xRange, yRange)))
        gameMap.addChild(createObject(folder: "Bins/", name: "binYellow", position: self.matrix(x: 6, y: 2, xRange, yRange)))
        
        self.addChild(gameMap)
    }
    
    // convert position
    func matrix (x posX: CGFloat, y posY: CGFloat, _ xRange: SKRange, _ yRange: SKRange) -> CGPoint {
        return CGPoint(x: xRange.lowerLimit + posX*tileSize, y: yRange.lowerLimit + (lines-1 - posY)*tileSize)
    }
}

