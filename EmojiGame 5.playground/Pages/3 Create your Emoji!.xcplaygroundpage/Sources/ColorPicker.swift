import Foundation
import UIKit
import SpriteKit

class ColorPicker: SKSpriteNode {
    
    var nodeName: String?
    var colors: [UIColor]?
    var nodePosition: CGPoint?
    var colorName: [String]?
    
    func setup(colors: [UIColor]?, nodeName: String?, position: CGPoint, size: CGSize, colorName: [String]?) {
        self.nodeName = nodeName
        self.position = position
        if let colors = colors {
            self.isHidden = false 
            let newWidth = 100 + CGFloat(50 * colors.count)
            self.size = CGSize(width: newWidth, height: self.size.height)
            self.color = .white
            self.colorName = colorName
            let initPosition = CGPoint(x: position.x , y: 0)
            for index in colors.indices {
                let circle = SKShapeNode(circleOfRadius: 15)
                circle.position = CGPoint(x: initPosition.x + CGFloat((index * 50)), y: 0)
                circle.fillColor = colors[index]
                if let colorName = colorName {
                    circle.name = colorName[index]
                }
                self.addChild(circle)
            }
        } else {
            self.isHidden = true
        }
    }
    
    func updateColors(colors: [UIColor]?, colorName: [String]?) {
        self.setup(colors: colors, nodeName: self.nodeName, position: self.position, size: self.size, colorName: colorName)
    }
    
    func cleanColors() {
        removeAllChildren()
    }
}
