import PlaygroundSupport
import SpriteKit

// Font
let cfURL = Bundle.main.url(forResource: "PressStart2P-Regular", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)

// Load the initial scene (Home)
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
let scene = InitialScene(size: CGSize(width: 1024, height: 768))
scene.backgroundColor = #colorLiteral(red: 0.7093039155, green: 0.2193932235, blue: 0.3572371602, alpha: 1)
scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

// Set the scale mode to scale to fit the window
scene.scaleMode = .aspectFill

// Present the scene
sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
