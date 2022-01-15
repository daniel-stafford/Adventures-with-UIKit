//
//  GameScene.swift
//  SpaceRace
//
//  Created by Daniel Stafford on 1/14/22.
//

import GameplayKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!

    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    // all possible things to throw at the player
    let possibleEnemies = ["ball", "hammer", "tv"]
    // note the new type Timer
    var gameTimer: Timer?
    var isGameOver = false

    override func didMove(to view: SKView) {
        backgroundColor = .black

        starfield = SKEmitterNode(fileNamed: "starfield")!
        // right end, halfway up
        starfield.position = CGPoint(x: 1024, y: 384)
        // prefill screen with starfield (move 10 seconds worth of starts)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1

        player = SKSpriteNode(imageNamed: "player")
        // in a bit and halway up
        player.position = CGPoint(x: 100, y: 384)
        // create physics body by drawing around player's texture
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        // we care about colliding with other thingsi n our game
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        // bottom left corner
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)

        // will trigger our didSet property observor
        score = 0

        // graivtiy is zero as well as in sapce
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        // tell us when contacts happen
        physicsWorld.contactDelegate = self

        // create our timer, new enemy every three seconds
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }

    @objc func createEnemy() {
        // else should never occur but randomElement requires it.
        guard let enemy = possibleEnemies.randomElement() else { return }

        let sprite = SKSpriteNode(imageNamed: enemy)
        // place at random vertical position on right side of screen
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50 ... 736))
        addChild(sprite)

        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        // allow to colldie with player
        sprite.physicsBody?.categoryBitMask = 1
        // moving hard to the left at constant rate
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        // constant spin as moving
        sprite.physicsBody?.angularVelocity = 5
        // no slow down over time
        sprite.physicsBody?.linearDamping = 0
        // no spin slow down over time
        sprite.physicsBody?.angularDamping = 0
    }

    override func update(_ currentTime: TimeInterval) {
        for node in children {
            // if node is off screen, remove it
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }

        if !isGameOver {
            score += 1
        }
    }
}
