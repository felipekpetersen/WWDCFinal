/*:

# That is it?
 
 That was... kind of boring. 😒
 I think we need different objects to represent diversity of people. We need more identity. We need to feel that we are part of something, that we are all special! 🌟
 
 So let's give it another try. But we will make it different, making it our way!
 
 There are a few more commands now.
 First, select your skin tone, using one emoji from the options.
 Next, run the code! You will see a difference on the face color.
 Now, let's add some identity for it! When you long press some object, it will show some more options. To change its color, select the object and chose some color from the top left picker.
 
 Have fun! And when you are happy with your emoji, press "Done" on the bottom!
 
 Thank you for playing, and I hope you had enjoyed it! 👋🏻
 
*/

//options: 👨‍🦲 👨🏻‍🦲 👨🏼‍🦲 👨🏽‍🦲 👨🏾‍🦲 👨🏿‍🦲
let skinTone = /*#-editable-code Skin tone*/"👨🏻‍🦲"/*#-end-editable-code*/

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
        scene.skinTone = self.getSkinTone(skinTone: skinTone)
        sceneView.presentScene(scene)
        self.view = sceneView
    }
    func getSkinTone(skinTone: String) -> String{
        switch skinTone {
        case "👨‍🦲":
            return "skin0"
        case "👨🏻‍🦲":
            return "skin1"
        case "👨🏼‍🦲":
            return "skin2"
        case "👨🏽‍🦲":
            return "skin03"
        case "👨🏾‍🦲":
            return "skin4"
        case "👨🏿‍🦲":
            return "skin5"
        default:
            return "skin0"
        }
    }
}

let vc = ViewController()
vc.preferredContentSize = CGSize(width: 640, height: 480)

PlaygroundPage.current.liveView = vc
//#-end-hidden-code
