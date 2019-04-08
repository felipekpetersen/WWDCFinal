import Foundation
import SpriteKit

public class GameScene: SKScene {
    
    //    private var spinnyNode : SKShapeNode!
    private var emojisLabel = [SKLabelNode?]()
    var backgroundImageNode = SKSpriteNode()
    
    public override func didMove(to view: SKView) {
        setupBackground()
        
        let emojisArray = ["👦🏼" , "👩🏿‍🦳", "👴🏼" , "💂🏼‍♀️" , "👸🏽", "👨🏼‍🚀" , "👵🏽" , "👩🏼‍🍳" , "👷🏻‍♀️", "👩🏾‍🍳" , "👨🏼‍🏫" , "👳🏾‍♂️" , "👩🏿‍🎓"]
        for index in emojisArray.indices {
            let label = SKLabelNode()
            label.text = emojisArray[index]
            emojisLabel.append(label)
        }
        
        for emojiLabel in emojisLabel {
            let x:Double = 50
            let boolx = Bool.random()
            let multiplierx: Double = boolx ? -1 : 1
            let y = Double.random(in: -50...50)
            emojiLabel?.position = CGPoint(x: x * multiplierx, y: y)
            emojiLabel?.fontSize = 50
            emojiLabel?.physicsBody = SKPhysicsBody(circleOfRadius: 25)
            emojiLabel?.physicsBody?.allowsRotation = false
            print("add")
            addChild(emojiLabel!)
        }
        
        self.physicsBody?.friction = 1
    }
    
    func setupBackground() {
        let backgroundImage = UIImage(named: "background_emoji")
        if let image = backgroundImage {
            let textureBack = SKTexture(image: image)
            backgroundImageNode = SKSpriteNode(texture: textureBack)
        }
        backgroundImageNode.setScale(0.5)
        addChild(backgroundImageNode)
        
    }
}
