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
    
    var doneButton: SKSpriteNode?
    var timer: Timer?
    var clothes = ["clothes1", "clothes2", "clothes3"]
    public var skinTone: String?
    
    var picker = ColorPicker()
    var colorpicker = SKSpriteNode()
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
        createColorPicker()
        setupSkinTone()
        createDoneButton()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        self.view?.addGestureRecognizer(longPress)
        
    }
    
    @objc func didLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let vc = self.view?.window?.rootViewController
            let modal = SelectionCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
            if let drag = currentImageDrag as? FacePartNode, drag.images != nil {
                if drag.name == "mouthimage" { 
                    modal.images = drag.images!
                } else {
                    modal.images = setupImagesColor(images: drag.images, imageSelected: drag.selectedImage!)
                }
                print(modal.images)
                modal.delegate = self
                modal.modalPresentationStyle = .overFullScreen
                modal.modalTransitionStyle = .crossDissolve
                vc?.present(modal, animated: true, completion: nil)
            }
        }
    }
    
    func setupImagesColor(images: [String]?, imageSelected: String) -> [String] {
        let splitColor = imageSelected.split(separator: "_")
        if let images = images {
            var auxImages = images
            for index in images.indices {
                let split = images[index].split(separator: "_")
                auxImages[index] = String(split[0] + "_" + splitColor[1])
                print(auxImages[index])
            }
        
            return auxImages
        }
        return [""]
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "donebutton" {
                    doneButtonTapped()
                }
                if let node = node as? SKShapeNode {
                    detectColorPick(node: node)
                }
                else if node.name != nil {
                    self.currentImageDrag = node
                    if let currenteFace = currentImageDrag as? FacePartNode {
                        self.nodeToChangeColor = currenteFace
                    }
                    node.setScale(bigScale)
                    self.updateColors(colors: (node as? FacePartNode)?.colors, colorName: (node as? FacePartNode)?.colorName)
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
    
    func createDoneButton() {
        if let image = UIImage(named: "doneButton") {
            let texture = SKTexture(image: image)
            self.doneButton = SKSpriteNode(texture: texture)
        }
        self.doneButton?.position = CGPoint(x: -(self.view?.frame.width)!/2 + 70 , y:  -(self.view?.frame.height)!/2 + 40)
        print(-(self.view?.frame.width)!)
        doneButton?.setScale(0.5)
        doneButton?.name = "donebutton"
        addChild(doneButton!)
    }
    
    func doneButtonTapped() {
        self.doneButton?.isHidden = true
        self.isUserInteractionEnabled = false
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveObject), userInfo: nil, repeats: true)
    }
    
    @objc func moveObject() {
        if clothes.count == 0 {
            timer?.invalidate()
            showEndindText()
        } else {
            let image = UIImage(named: clothes[0])
            clothes.remove(at: 0)
            print(clothes)
            var spriteNode = SKSpriteNode()
            if let image = image {
                let texture = SKTexture(image: image)
                spriteNode = SKSpriteNode(texture: texture)
                spriteNode.setScale(bigScale)
            }
            if let widht = self.view?.frame.width {
                let pos: CGFloat = ( -2 * widht)
                let moveAction = SKAction.moveTo(x: pos, duration: 4)
                spriteNode.position = CGPoint(x: self.view?.frame.width ?? 0, y: 0)
                spriteNode.run(moveAction)
            }
            addChild(spriteNode)
            }
    }
    
    func showEndindText() {
        let fadeOutAction = SKAction.fadeOut(withDuration: 2)
        let fadeInAction = SKAction.fadeIn(withDuration: 2)
        var endingNode = SKSpriteNode()
        let endingImage = UIImage(named: "ending")
        if let image = endingImage {
            let texture = SKTexture(image: image) 
            endingNode = SKSpriteNode(texture: texture) 
        }
        endingNode.alpha = 0 
        addChild(endingNode)
        endingNode.run(fadeInAction)
        face.run(fadeOutAction)
        noses.run(fadeOutAction)
        eyes.run(fadeOutAction)
        eyebrows.run(fadeOutAction)
        hairs.run(fadeOutAction)
        mouths.run(fadeOutAction)
    }
    
    func detectColorPick(node: SKShapeNode) {
        let split = nodeToChangeColor.selectedImage?.split(separator: "_")
        if let name = split, let nodeName = node.name {
            nodeToChangeColor.updateImage(image: name[0] + "_" + nodeName)
        }
    }
    
    func dismissPicker() {
        let action = SKAction.move(to: CGPoint(x: self.picker.position.x,y: self.picker.position.y - 50), duration: 2.0)
        print("moveu")
        picker.run(action)
    }
    
    func showPicker() {
        let action = SKAction.move(to: CGPoint(x: self.picker.position.x,y: self.picker.position.y + 50), duration: 2.0)
        print("moveu")
        picker.run(action)
    }
    
    func updateColors(colors: [UIColor]?, colorName: [String]?) {
        self.picker.cleanColors()
        self.picker.updateColors(colors: colors, colorName: colorName)
    }
    
    func createColorPicker() {
        self.picker.setup(colors: nil, nodeName: nil, position: CGPoint(x:(((self.view?.frame.width ?? 0)/2) * (-1)) + 175 , y: (self.view?.frame.height ?? 0)/2 - 25), size: CGSize(width: 350, height: 50), colorName: nil)
            addChild(picker)
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

extension GameScene: SelectionCollectionViewControllerDelegate {
    func didChose(image: String) {
        let texture = SKTexture(imageNamed: image)
        let action = SKAction.setTexture(texture, resize: true)
        let node = currentImageDrag as! FacePartNode
        node.selectedImage = image
        node.run(action)
        self.currentImageDrag = nil
    }
    
}
