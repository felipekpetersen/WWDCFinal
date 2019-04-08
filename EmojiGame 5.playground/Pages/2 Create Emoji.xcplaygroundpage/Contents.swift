
/*:
 # Create!
 
 So, let's make our very first emoji!
 
 We just need to drag all the parts into the face, and that is it!
 
 
 Run the code and build the emoji, when you are done, go to next page.
 */

//#-hidden-code
import UIKit
import PlaygroundSupport
import SpriteKit


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
let scene = GameScene()

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scene.scaleMode = .aspectFit
        sceneView.presentScene(scene)
        self.view = sceneView
    }

}

let vc = ViewController()
vc.preferredContentSize = CGSize(width: 640, height: 480)

PlaygroundPage.current.liveView = vc
//#-end-hidden-code
