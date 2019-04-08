import Foundation
import UIKit
import SpriteKit

class FacePartNode: SKSpriteNode {
    var nodeName: String?
    var selectedImage: String?
    var images: [String]?
    var scale: CGFloat?
    var nodePosition: CGPoint?
    var colors: [UIColor]?
    var colorName: [String]?
    
    func setup(name: String?, selectedImage: String, images: [String]?, scale: CGFloat, position: CGPoint, colors: [UIColor]?, colorName: [String]?) {
        self.nodeName = name
        self.selectedImage = selectedImage
        self.images = images
        self.scale = scale
        self.nodePosition = position
        self.colors = colors
        self.colorName = colorName
        let image = UIImage(named: selectedImage)
        if let image = image {
            let texture = SKTexture(image: image)
            let action = SKAction.setTexture(texture, resize: true)
            self.run(action)
            self.position = position
            self.setScale(scale)
        }
        self.name = nodeName
    }
    
    func updateImage(image: String) {
        let texture = SKTexture(imageNamed: image)
        let action = SKAction.setTexture(texture, resize: true)
        self.selectedImage = image 
        self.run(action)
    }
}
