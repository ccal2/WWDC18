import PlaygroundSupport
import SpriteKit

// Font
let cfURL = Bundle.main.url(forResource: "PressStart2P-Regular", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
if let scene = GameScene(fileNamed: "Scene") {
    scene.backgroundColor = #colorLiteral(red: 0.7093039155, green: 0.2193932235, blue: 0.3572371602, alpha: 1)

    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill

    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
