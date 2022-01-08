//
//  GameScene.swift
//  Pachinko
//
//  Created by Daniel Stafford on 1/8/22.
//

import SpriteKit

// allow us to use SKPhysicsContactDelegate
class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    var editLabel: SKLabelNode!

    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }

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

        // Set up delegate from SKScene
        physicsWorld.contactDelegate = self

        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)

        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        // top right of screen
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)

        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        // top left of screen
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
    }

    // user touches the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // first touch (at least one)
        if let touch = touches.first {
            // where did the touch happen in the whole of my game scene
            let location = touch.location(in: self)

            // what nodes exist at the touch location in our scene
            let objects = nodes(at: location)

            // did the user tap the edit button?
            if objects.contains(editLabel) {
                // if so, toggle it
                editingMode.toggle()
            } else {
                if editingMode {
                    // edit is true
                    // create a barrier box
                    // random size
                    let size = CGSize(width: Int.random(in: 16 ... 128), height: 16)
                    // random color
                    let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0 ... 1), green: CGFloat.random(in: 0 ... 1), blue: CGFloat.random(in: 0 ... 1), alpha: 1), size: size)
                    // random rotation
                    box.zRotation = CGFloat.random(in: 0 ... 3)
                    box.position = location
                    box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                    box.physicsBody?.isDynamic = false
                    addChild(box)
                } else {
                    // edit is false
                    // create a ball
                    let ball = SKSpriteNode(imageNamed: "ballRed")
                    // circueOfRadius - will behave as ball rather than square
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                    // 0 to 1 (not bouncey to super boundey
                    // note that physicsBody is optional (even though we just created it)
                    ball.physicsBody?.restitution = 0.4
                    // collisionBitMask = which things should I bump into? By default, set to everything
                    // contactTestBitMask = which colliosions do you want to know about? by default set to nothing
                    // so, bounce off everything and tell us all about each bounce (OK for simple games)
                    ball.physicsBody!.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    // balls from top of screen
                    ball.position = CGPoint(x: location.x, y: 700)
                    // name for tracking
                    ball.name = "ball"
                    addChild(ball)
                }
            }
        }
    }

    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        // object will be fixed in place (but can still collide with things)
        bouncer.physicsBody?.isDynamic = false
        // bouncer doesn't need name, as we don't care when get hit
        addChild(bouncer)
    }

    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode

        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            // name for tracking
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            // name for tracking
            slotBase.name = "bad"
        }

        slotBase.position = position
        slotGlow.position = position

        // allows us to recogize when the ball go through a slot
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false

        addChild(slotBase)
        addChild(slotGlow)

        // angle in radians, so pi radians = 180 degrees
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }

    // SKNode is parent class of all dfifferent types of nodes, we don't really care what kind
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
        }
    }

    func destroy(ball: SKNode) {
        ball.removeFromParent()
    }

    //  check contact between ball - object or object - ball (not ball - ball)
    func didBegin(_ contact: SKPhysicsContact) {
        // double collision may occur (ball hits slot, slot hits ball), so this prevents running twice
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        // first node is ball
        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
            // second node is ball
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
}
