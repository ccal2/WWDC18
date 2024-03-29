import SpriteKit

class GameScene: SKScene {
    var garbageCount: Int = 0
    var garbageOutCount: Int = 0
    
    override func didMove (to view: SKView) {
        self.loadLegend()
        self.loadButtons()
        self.loadGameMap()
    }

    func touchButton (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        let gameMap = self.childNode(withName: "gameMap")!
        let player = gameMap.childNode(withName: "player")!
        
        if button.name == "arrowRight" {
            self.addChild(self.createObject(folder: "Arrows/", name: "arrowRight_h", position: arrowRightPos))
            self.move("Right", from: player.position, x: tileSize, y: 0)
        } else if button.name == "arrowDown" {
            self.addChild(self.createObject(folder: "Arrows/", name: "arrowDown_h", position: arrowDownPos))
            self.move("Front", from: player.position, x: 0, y: -tileSize)
        } else if button.name == "arrowLeft" {
            self.addChild(self.createObject(folder: "Arrows/", name: "arrowLeft_h", position: arrowLeftPos))
            self.move("Left", from: player.position, x: -tileSize, y: 0)
        } else if button.name == "arrowUp" {
            self.addChild(self.createObject(folder: "Arrows/", name: "arrowUp_h", position: arrowUpPos))
            self.move("Back", from: player.position, x: 0, y: tileSize)
        }
    }
    
    func Highlight (atPoint pos: CGPoint) {
        let button = self.atPoint(pos)
        
        if button.name == "arrowLeft_h" || button.name == "arrowRight_h" || button.name == "arrowUp_h" || button.name == "arrowDown_h" {
            button.removeFromParent()
        }
    }
    
    func move (_ direction: String, from position: CGPoint, x: CGFloat, y: CGFloat) {
        let gameMap = self.childNode(withName: "gameMap")!
        let oldPlayer = gameMap.childNode(withName: "player")!
        let player = createPlayer(imageNamed: "player\(direction)", position: position)
        
        oldPlayer.removeFromParent()
        gameMap.addChild(player)
        
        let node = gameMap.atPoint(CGPoint(x: player.position.x + x, y: player.position.y + y))
        
        if node.name!.prefix(7) == "garbage" {
            let indexGarbage = node.name!.index(node.name!.startIndex, offsetBy: 7)
            let colorGarbage = node.name![indexGarbage...]
            
            // verify where it's going
            let other_node = gameMap.atPoint(CGPoint(x: player.position.x + 2*x, y: player.position.y + 2*y))
            
            if other_node.name != "tree" && other_node.name!.prefix(7) != "garbage" && other_node.name!.prefix(3) != "bin" {
                self.movement(object: node, x, y)
                self.movement(object: player, x, y)
            }
            
            if other_node.name!.prefix(3) == "bin" {
                let indexBin = other_node.name!.index(other_node.name!.startIndex, offsetBy: 3)
                let colorBin = other_node.name![indexBin...]
                
                if colorGarbage == colorBin {
                    self.movement(object: node, x, y)
                    self.movement(object: player, x, y)
                    
                    // delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        // remove the garbage
                        node.removeFromParent()
                        
                        self.garbageOutCount -= 1
                        
                        self.checkIfWon()
                    }
                }
            } else {
                self.checkIfLost(gameMap, node, other_node, String(colorGarbage))
            }
            
        } else if node.name!.prefix(4) != "tree" && node.name!.prefix(3) != "bin" {
            self.movement(object: player, x, y)
        }
    }
    
    func movement (object: SKNode, _ x: CGFloat, _ y: CGFloat) {
        for _ in 1...Int(frames) {
            object.position = CGPoint(x: object.position.x + (x/frames), y: object.position.y + (y/frames))
        }
    }
    
    func checkIfWon () {
        if self.garbageOutCount == 0 {
            let labels = [createLabel(text: "Congratulations!", position: CGPoint(x: 0, y: 96), size: 24), createLabel(text: "You've cleaned the park!", position: CGPoint(x: 0, y: 160))]
            
            let scene = EndGameScene(size: sceneSize, labels: labels)
            scene.backgroundColor = #colorLiteral(red: 0.7093039155, green: 0.2193932235, blue: 0.3572371602, alpha: 1)
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            scene.scaleMode = .aspectFill
            
            let transition = SKTransition.fade(with: #colorLiteral(red: 0.645771694, green: 0.2032078091, blue: 0.3298983863, alpha: 1), duration: 1)
            
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
    func checkIfLost (_ gameMap: SKNode, _ node: SKNode, _ other_node: SKNode, _ colorGarbage: String) {
        var lost = false
        var nearNodes: [SKNode] = []
        var pinned: [Bool] = [false, false, false, false] // 0 - right; 1 - down; 2 - left; 3 - up
        
        let nearRight = gameMap.atPoint(CGPoint(x: node.position.x + tileSize, y: node.position.y))
        let nearDown = gameMap.atPoint(CGPoint(x: node.position.x, y: node.position.y - tileSize))
        let nearLeft = gameMap.atPoint(CGPoint(x: node.position.x - tileSize, y: node.position.y))
        let nearUp = gameMap.atPoint(CGPoint(x: node.position.x, y: node.position.y + tileSize))
        
        nearNodes.append(nearRight)
        nearNodes.append(nearDown)
        nearNodes.append(nearLeft)
        nearNodes.append(nearUp)
        
        for i in 0...(nearNodes.count-1) {
            if nearNodes[i].name == "tree" {
                pinned[i] = true
            } else if nearNodes[i].name!.prefix(3) == "bin" {
                let indexBin = nearNodes[i].name!.index(other_node.name!.startIndex, offsetBy: 3)
                let colorBin = nearNodes[i].name![indexBin...]
                
                if colorBin != colorGarbage {
                    pinned[i] = true
                }
            }
        }
        
        for i in 0...3 {
            if pinned[i] && pinned[(i+1)%4] {
                lost = true
                break
            }
        }
        
        if lost {
            let label = [createLabel(text: "Oh no! You've trapped the garbage", position: CGPoint(x: 0, y: 96), size: 24)]
            
            let scene = EndGameScene(size: sceneSize, labels: label)
            scene.backgroundColor = #colorLiteral(red: 0.3287855243, green: 0.3323060302, blue: 0.3478847121, alpha: 1)
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            scene.scaleMode = .aspectFill
            
            let transition = SKTransition.fade(with: #colorLiteral(red: 0.3287855243, green: 0.3323060302, blue: 0.3478847121, alpha: 1), duration: 1)
            
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
    func loadLegend () {
        // icons
        self.addChild(self.createObject(folder: "Bins/", name: "binBlue", position: CGPoint(x: 256, y: 240)))
        self.addChild(self.createObject(folder: "Bins/", name: "binGreen", position: CGPoint(x: 256, y: 176)))
        self.addChild(self.createObject(folder: "Bins/", name: "binRed", position: CGPoint(x: 256, y: 112)))
        self.addChild(self.createObject(folder: "Bins/", name: "binYellow", position: CGPoint(x: 256, y: 48)))
        
        // names
        self.addChild(createLabel(text: "Paper", position: CGPoint(x: 307, y: 224), alignmentH: SKLabelHorizontalAlignmentMode.left))
        self.addChild(createLabel(text: "Glass", position: CGPoint(x: 307, y: 160), alignmentH: SKLabelHorizontalAlignmentMode.left))
        self.addChild(createLabel(text: "Plastic", position: CGPoint(x: 307, y: 96), alignmentH: SKLabelHorizontalAlignmentMode.left))
        self.addChild(createLabel(text: "Metal", position: CGPoint(x: 307, y: 32), alignmentH: SKLabelHorizontalAlignmentMode.left))
    }
    
    func loadButtons () {
        self.addChild(self.createObject(folder: "Arrows/", name: "arrowRight", position: arrowRightPos))
        self.addChild(self.createObject(folder: "Arrows/", name: "arrowDown", position: arrowDownPos))
        self.addChild(self.createObject(folder: "Arrows/", name: "arrowLeft", position: arrowLeftPos))
        self.addChild(self.createObject(folder: "Arrows/", name: "arrowUp", position: arrowUpPos))
    }
    
    func loadGameMap () {
        // grass background
        let gameMap = SKSpriteNode(imageNamed: "grassMap")
        gameMap.name = "gameMap"
        gameMap.position = CGPoint(x: -128, y: 0)
        
        // middle position
        let xMiddle = xRange.lowerLimit + columns/2 * tileSize
        let yMiddle = yRange.lowerLimit + lines/2 * tileSize
        
        // trees
        for i in 0...(Int(columns)-1) {
            let j = CGFloat(i)
            gameMap.addChild(self.createObject(name: "tree", position: self.matrix(x: j, y: 0, xRange, yRange)))
            gameMap.addChild(self.createObject(name: "tree", position: self.matrix(x: j, y: lines-1, xRange, yRange)))
        }
        
        for i in 1...(Int(lines)-2) {
            let j = CGFloat(i)
            gameMap.addChild(self.createObject(name: "tree", position: self.matrix(x: 0, y: j, xRange, yRange)))
            gameMap.addChild(self.createObject(name: "tree", position: self.matrix(x: columns-1, y: j, xRange, yRange)))
        }
        
        gameMap.addChild(self.createObject(name: "tree", position: self.matrix(x: 8, y: 6, xRange, yRange)))
        gameMap.addChild(self.createObject(name: "tree", position: self.matrix(x: 1, y: 5, xRange, yRange)))
        gameMap.addChild(self.createObject(name: "tree", position: self.matrix(x: 2, y: 5, xRange, yRange)))
        gameMap.addChild(self.createObject(name: "tree", position: self.matrix(x: 4, y: 5, xRange, yRange)))
        gameMap.addChild(self.createObject(name: "tree", position: self.matrix(x: 8, y: 4, xRange, yRange)))
        gameMap.addChild(self.createObject(name: "tree", position: self.matrix(x: 1, y: 3, xRange, yRange)))
        gameMap.addChild(self.createObject(name: "tree", position: self.matrix(x: 5, y: 1, xRange, yRange)))
        
        // garbages
        gameMap.addChild(self.createObject(folder: "Garbages/", name: "garbageGreen", position: self.matrix(x: 7, y: 5, xRange, yRange)))
        gameMap.addChild(self.createObject(folder: "Garbages/", name: "garbageRed", position: self.matrix(x: 3, y: 5, xRange, yRange)))
        gameMap.addChild(self.createObject(folder: "Garbages/", name: "garbageRed", position: self.matrix(x: 6, y: 3, xRange, yRange)))
        gameMap.addChild(self.createObject(folder: "Garbages/", name: "garbageBlue", position: self.matrix(x: 5, y: 5, xRange, yRange)))
        gameMap.addChild(self.createObject(folder: "Garbages/", name: "garbageBlue", position: self.matrix(x: 7, y: 2, xRange, yRange)))
        gameMap.addChild(self.createObject(folder: "Garbages/", name: "garbageYellow", position: self.matrix(x: 4, y: 2, xRange, yRange)))
        self.garbageOutCount = self.garbageCount
        
        // bins
        gameMap.addChild(self.createObject(folder: "Bins/", name: "binBlue", position: self.matrix(x: 6, y: 2, xRange, yRange)))
        gameMap.addChild(self.createObject(folder: "Bins/", name: "binGreen", position: self.matrix(x: 1, y: 1, xRange, yRange)))
        gameMap.addChild(self.createObject(folder: "Bins/", name: "binRed", position: self.matrix(x: 3, y: 6, xRange, yRange)))
        gameMap.addChild(self.createObject(folder: "Bins/", name: "binYellow", position: self.matrix(x: 8, y: 5, xRange, yRange)))
        
        // player
        let player = createPlayer(imageNamed: "playerFront", position: CGPoint(x: xMiddle, y: yMiddle))
        gameMap.addChild(player)
        
        // limit the players's movements according to the map
        player.constraints = [SKConstraint.positionX(xRange, y: yRange)]
        
        // add to the tree
        self.addChild(gameMap)
    }
    
    func createObject (folder: String = "", name: String, position: CGPoint) -> SKSpriteNode {
        let object = SKSpriteNode(imageNamed: "\(folder)\(name)")
        object.position = position
        object.name = name
        
        if name.prefix(7) == "garbage" {
            object.zPosition = 1
            self.garbageCount += 1
        } else {
            object.zPosition = 0
        }
        
        return object
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
