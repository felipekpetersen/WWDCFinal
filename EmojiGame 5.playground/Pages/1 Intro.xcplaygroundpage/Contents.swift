
/*:
 # EmojiDiversity
 Hello! 🙋🏻‍♂️ My name is Felipe Kaça Petersen and I am a brazilian 🇧🇷 computer science student! 👨🏻‍💻
 
 On my playground I want to talk about diversity and how different cultures and people are represented. To do this, we will use emojis! 😀
 Brazil is a great place to talk about it, since here we have a lot of cultures, mostly because we were colonized by many contries.
 
 Just like emojis, we "update" and look to diversity as a really important thing for our world.
 Back in 2015, when they published the first version of Emoji, there were not much diversity, and the only face color was yellow. Since then, they started to make different types of emoji to represent different kind of people and characters. And that is exacly what we are doing in this playground!
 
 So let's get start with it!
 
 Run the code to see the intro and a little surprise in the middle of the screen!
 When you are done, go to the next page to continue
 */

//#-hidden-code
import PlaygroundSupport
import SpriteKit

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
let scene = GameScene(fileNamed: "GameScene")
scene?.scaleMode = .aspectFill
sceneView.presentScene(scene)


PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
//#-end-hidden-code
