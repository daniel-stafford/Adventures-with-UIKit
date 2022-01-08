//
//  GameScene.swift
//  Pachinko
//
//  Created by Daniel Stafford on 1/8/22.
//

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        // if you want to place an image in your game, the class to use is called SKSpriteNode, and it can load any picture from your app bundle just like UIImage.
        let background = SKSpriteNode(imageNamed: "background.jpg")
        // place image in center
        background.position = CGPoint(x: 512, y: 384)
        // The .replace option means "just draw it, ignoring any alpha values," which makes it fast for things without gaps such as our background.
        background.blendMode = .replace
        // a zPosition of -1, which in our game means "draw this behind everything else."
        background.zPosition = -1
        // add any node to the current screen, you use the addChild() method. As you might expect, SpriteKit doesn't use UIViewController. Yes, there is a view controller in your project, but it's there to host your SpriteKit game. The equivalent of screens in SpriteKit are called scenes.
        addChild(background)
        // apply physicsBody to the whole scene
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

    }

    // user touches the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // first touch (at least one)
        if let touch = touches.first {
            // where did the touch happen in the whole of my game scene
            let location = touch.location(in: self)
            // create new sprite node box
            let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 64, height: 64))
           // gives physics body matching the box size tiself
            box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
            // put new sprite node box at the location
            box.position = location
            // add to game scene
            addChild(box)
        }
    }
}
