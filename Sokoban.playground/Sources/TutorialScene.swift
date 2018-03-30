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
        
        // add player
        let playerFront = createObject(folder: "Player/", name: "playerFront", position: self.matrix(x: 2, y: 3, xRange, yRange))
        playerFront.constraints = [SKConstraint.positionX(xRange, y: yRange)]
        gameMap.addChild(playerFront)
        
        let playerRight = createObject(folder: "Player/", name: "playerRight", position: self.matrix(x: 2, y: 3, xRange, yRange))
        playerRight.constraints = [SKConstraint.positionX(xRange, y: yRange)]
        playerRight.isHidden = true
        gameMap.addChild(playerRight)
        
        // get garbage
        let garbage = gameMap.childNode(withName: "garbageBlue")!
        
        // animation
        let actionPlayerFront = SKAction.sequence([SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 4.5), SKAction.unhide()])
        let actionPlayerRight = SKAction.sequence([SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.unhide(), SKAction.moveBy(x: tileSize*3, y: 0, duration: 3), SKAction.moveBy(x: 0, y: 0, duration: 1.5), SKAction.hide(), SKAction.moveBy(x: -tileSize*3, y: 0, duration: 0)])
        let actionGarbage = SKAction.sequence([SKAction.moveBy(x: 0, y: 0, duration: 2), SKAction.moveBy(x: tileSize*2, y: 0, duration: 2), SKAction.moveBy(x: 0, y: 0, duration: 0.5), SKAction.hide(), SKAction.moveBy(x: 0, y: 0, duration: 1), SKAction.moveBy(x: -tileSize*2, y: 0, duration: 0), SKAction.unhide()])
        
        playerFront.run(SKAction.repeatForever(actionPlayerFront))
        playerRight.run(SKAction.repeatForever(actionPlayerRight))
        garbage.run(SKAction.repeatForever(actionGarbage))
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
        
        // garbages
        gameMap.addChild(createObject(folder: "Garbages/", name: "garbageBlue", position: self.matrix(x: 4, y: 3, xRange, yRange)))
        
        
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

