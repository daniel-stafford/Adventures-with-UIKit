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

        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
    }

    // user touches the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // first touch (at least one)
        if let touch = touches.first {
            // where did the touch happen in the whole of my game scene
            let location = touch.location(in: self)

            let ball = SKSpriteNode(imageNamed: "ballRed")
            // circueOfRadius - will behave as ball rather than square
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
            // 0 to 1 (not bouncey to super boundey
            // note that physicsBody is optional (even though we just created it)
            ball.physicsBody?.restitution = 0.4
            ball.position = location
            addChild(ball)
        }
    }

    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        // object will be fixed in place (but can still collide with things)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }

    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode

        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
        }

        slotBase.position = position
        slotGlow.position = position

        addChild(slotBase)
        addChild(slotGlow)
        
        // angle in radians, so pi radians = 180 degrees
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
}
