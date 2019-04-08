
import Foundation
import PlaygroundSupport
import SpriteKit
import UIKit


public class GameScene: SKScene {
    
    var currentImageDrag: SKNode?
    var nodeToChangeColor = FacePartNode()
    var face = FacePartNode()
    var eyes = FacePartNode()
    var mouths = FacePartNode()  
    var noses = FacePartNode()
    var eyebrows = FacePartNode()
    var hairs = FacePartNode()

    var skinTone: String? = "skin0"
    var backgroundImageNode = SKSpriteNode()
    
    let smallScale:CGFloat = 0.4
    let extraSmallScale: CGFloat = 0.2
    let bigScale: CGFloat = 0.6
    let spaceItens: CGFloat = 100
    var isFaceTouch = false
    private var spinnyNode : SKShapeNode!
    
    public override func didMove(to view: SKView) {
        size = view.frame.size
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setupBackground()
        createObjects()
        setupSkinTone()
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "donebutton" {
                }
                if let node = node as? SKShapeNode {
                }
                else if node.name != nil {
                    self.currentImageDrag = node
                    if let currenteFace = currentImageDrag as? FacePartNode {
                        self.nodeToChangeColor = currenteFace
                    }
                    node.setScale(bigScale)
                } else {
                    self.currentImageDrag = nil
                }
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = currentImageDrag {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    
    func setupBackground() {
        let backgroundImage = UIImage(named: "background_emoji")
        let textureBack = SKTexture(image: backgroundImage!)
        backgroundImageNode = SKSpriteNode(texture: textureBack)
        backgroundImageNode.setScale(0.5)
    }
    
    func setupSkinTone() {
        let faceImage = "face_" + skinTone!
        let mouthImage = "mouth_" + skinTone!
        let noseImage = "nose_" + skinTone!
        face.setup(name:nil, selectedImage: faceImage, images: nil, scale: bigScale, position: CGPoint(x: -50, y: 0), colors: nil, colorName: nil)
        mouths.setup(name: "mouthimage", selectedImage: mouthImage, images: ["mouth_big_smile", "mouth_up_smile", "mouth_weird_smile"], scale: smallScale, position: CGPoint(x: size.width * 0.3, y: eyes.position.y + spaceItens), colors: nil, colorName: nil)
        noses.setup(name: "noseimage", selectedImage: noseImage, images: nil, scale: smallScale, position: CGPoint(x: size.width * 0.3, y: mouths.position.y + spaceItens), colors: nil, colorName: nil)
    }
    
    func createObjects() {
     
        eyes.setup(name: "eyeimage", selectedImage: "eye_black", images: ["eye_black", "eye1_black"], scale: smallScale, position: CGPoint(x: size.width * 0.3, y: -size.height * 0.4), colors: [.blue, .black, .green, .gray, .brown], colorName: ["blue", "black", "green", "gray", "brown"])
      
        eyebrows.setup(name: "eyebrowimage", selectedImage: "eyebrow_black", images: ["eyebrow_black", "eyebrowthin_black", "eyebrow1_black"], scale: smallScale, position: CGPoint(x: size.width * 0.3, y: noses.position.y + spaceItens), colors: [.black, .brown, .red, .yellow, UIColor(red: 0.427, green: 0.401, blue: 1.424, alpha: 1)], colorName: ["black", "brown", "red", "yellow", "darkbrown"])
        
        hairs.setup(name: "hairimage", selectedImage: "hairstyle3_black", images: ["hairstyle1", "hairstyle2", "hairstyle3", "hairstyle4", "hairstyle5", "hairstyle6", "hairstyle7", "hairstyle8"], scale: extraSmallScale, position: CGPoint(x: size.width * 0.3, y: eyebrows.position.y + spaceItens), colors: [.black, .brown, .red, .yellow, UIColor(red: 0.427, green: 0.401, blue: 1.424, alpha: 1)], colorName: ["black", "brown", "red", "yellow", "darkbrown"])

        addChild(backgroundImageNode)
        addChild(face)
        addChild(eyes)
        addChild(mouths)
        addChild(noses)
        addChild(eyebrows)
        addChild(hairs)
    }
    
}

