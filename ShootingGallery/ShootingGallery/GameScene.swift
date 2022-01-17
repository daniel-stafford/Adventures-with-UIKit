//
//  GameScene.swift
//  ShootingGallery
//
//  Created by Daniel Stafford on 1/16/22.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var gameScore: SKLabelNode!
    var gameTimer: Timer?

    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }

    let possibleEnemies = ["cage1", "cage2", "cage3"]

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "landscape")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        // place center in bottom left
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)

        score = 0

        // graivtiy is zero as well as in sapce
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        // tell us when contacts happen
        physicsWorld.contactDelegate = self

        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
    }

    @objc func createTarget() {
        // else should never occur but randomElement requires it.
        guard let enemy = possibleEnemies.randomElement() else { return }
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.setScale(0.5)
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
}
