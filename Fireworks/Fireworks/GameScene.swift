//
//  GameScene.swift
//  Fireworks
//
//  Created by Daniel Stafford on 1/19/22.
//

import GameplayKit
import SpriteKit

class GameScene: SKScene {
    var gameTimer: Timer?
    var fireworks = [SKNode]()
    var scoreLabel: SKLabelNode!
    let leftEdge = -22
    let bottomEdge = -22
    let rightEdge = 1024 + 22
    var timeInterval = 6

    var score = 0 {
        didSet {
//            scoreLabel.text = "Score: \(score)"
        }
    }

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        gameTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timeInterval), target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
    }

    func checkTouches(_ touches: Set<UITouch>) {
        guard let touch = touches.first else { return }

        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        // we want to cast all nodes as SKSpriteNode to be able to modify them (e.g. use colorBlendFactor
        // case for let XXXX as YYYYY in ZZZZZ
        for case let node as SKSpriteNode in nodesAtPoint {
            // if not firework go to next loop
            guard node.name == "firework" else { continue }

            // inner loop, be careful!
            // only one firework color at a time
            // parent will be container node (sprite and emitter)
            for parent in fireworks {
                // exit loop if we can get the spriteNode inside the parent node
                guard let firework = parent.children.first as? SKSpriteNode else { continue }

                // if prior firework color is different color from new
                if firework.name == "selected" && firework.color != node.color {
                    firework.name = "firework"
                    firework.colorBlendFactor = 1
                }
            }
            // we've touched it, so now selected firework
            node.name = "selected"
            // change to white color
            node.colorBlendFactor = 0
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkTouches(touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        checkTouches(touches)
    }

    override func update(_ currentTime: TimeInterval) {
        // loop through array backwards
        for (index, firework) in fireworks.enumerated().reversed() {
            // give players a little bit extra time
            if firework.position.y > 900 {
                // this uses a position high above so that rockets can explode off screen
                fireworks.remove(at: index)
                firework.removeFromParent()
            }
        }
    }

    func createFirework(xMovement: CGFloat, x: Int, y: Int) {
        // 1
        let node = SKNode()
        // place where method called
        node.position = CGPoint(x: x, y: y)

        // 2
        let firework = SKSpriteNode(imageNamed: "rocket")
        // color by full amount
        firework.colorBlendFactor = 1
        firework.name = "firework"
        // put inside the node
        node.addChild(firework)

        // 3 random firework colors
        switch Int.random(in: 0 ... 2) {
        case 0:
            firework.color = .cyan

        case 1:
            firework.color = .green

        case 2:
            firework.color = .red

        default:
            break
        }

        // 4
        // can be straight, curved, whatever
        let path = UIBezierPath()
        // make start where rocket starts
        path.move(to: .zero)
        // regardless of x movement, move up the screen
        path.addLine(to: CGPoint(x: xMovement, y: 1000))

        // 5
        // speed most useful, don't care how long takes
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        // use follow action
        node.run(move)

        // 6
        // add emitter just behind
        if let emitter = SKEmitterNode(fileNamed: "fuse") {
            emitter.position = CGPoint(x: 0, y: -22)
            node.addChild(emitter)
        }

        // 7
        // add to fireworks array
        fireworks.append(node)
        // add to game scene
        addChild(node)
    }

    @objc func launchFireworks() {
        let movementAmount: CGFloat = 1800

        switch Int.random(in: 0 ... 3) {
        case 0:
            // fire five, straight up
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 - 200, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 - 100, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 + 100, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 + 200, y: bottomEdge)

        case 1:
            // fire five, in a fan
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: -200, x: 512 - 200, y: bottomEdge)
            createFirework(xMovement: -100, x: 512 - 100, y: bottomEdge)
            createFirework(xMovement: 100, x: 512 + 100, y: bottomEdge)
            createFirework(xMovement: 200, x: 512 + 200, y: bottomEdge)

        case 2:
            // fire five, from the left to the right
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)

        case 3:
            // fire five, from the right to the left
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)

        default:
            break
        }
    }

    func explode(firework: SKNode) {
        if let emitter = SKEmitterNode(fileNamed: "explode") {
            emitter.position = firework.position
            addChild(emitter)
        }

        firework.removeFromParent()
    }

    func explodeFireworks() {
        // for adjusting score
        var numExploded = 0
        
        // loop backwards
        for (index, fireworkContainer) in fireworks.enumerated().reversed() {
            // safely check each is firework
            guard let firework = fireworkContainer.children.first as? SKSpriteNode else { continue }
            // explode the selected ones
            if firework.name == "selected" {
                // destroy this firework!
                explode(firework: fireworkContainer)
                fireworks.remove(at: index)
                numExploded += 1
            }
        }

        switch numExploded {
        case 0:
            break
        case 1:
            score += 200
        case 2:
            score += 500
        case 3:
            score += 1500
        case 4:
            score += 2500
        default:
            score += 4000
        }
    }
}
