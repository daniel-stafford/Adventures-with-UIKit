//
//  GameScene.swift
//  ShootingGallery
//
//  Created by Daniel Stafford on 1/16/22.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var gameTimer: Timer?
    var gameAmmo: SKLabelNode!
    var reload: SKLabelNode!
    var ammo = 5 {
        didSet {
            gameAmmo.text = "Shots left: \(ammo)"
        }
    }

    var gameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }

    let possibleTargets = ["snow", "snow2"]

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "mountains2")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.position = CGPoint(x: 8, y: 10)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        score = 0

        gameAmmo = SKLabelNode(fontNamed: "Chalkduster")
        gameAmmo.position = CGPoint(x: 650, y: 10)
        gameAmmo.horizontalAlignmentMode = .left
        gameAmmo.fontSize = 48
        gameAmmo.name = "ammo"
        addChild(gameAmmo)
        ammo = 6

        reload = SKLabelNode(fontNamed: "Chalkduster")
        reload.position = CGPoint(x: 800, y: 700)
        reload.text = "Reload"
        reload.horizontalAlignmentMode = .left
        reload.fontSize = 48
        reload.name = "ammo"

        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self

        gameTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)

        if ammo > 0 {
            ammo -= 1
        } else {
            ammo = 0
        }

        for node in tappedNodes {
            if node.name == "ammo" {
                ammo = 6
                node.removeFromParent()
            }
            if ammo > 0 {
                if node.name == "target" || node.name == "friend" {
                    let explosion = SKEmitterNode(fileNamed: "spark")!
                    explosion.position = node.position
                    addChild(explosion)
                    node.removeFromParent()
                }
                if node.name == "target" {
                    score += 1
                }
                if node.name == "friend" {
                    score -= 1
                }
            }
        }
        if ammo == 5 {
            addChild(reload)
        }
    }

    @objc func createTarget() {
        let makeEnemy = Bool.random()
        let sprite: SKSpriteNode!
        if makeEnemy {
            guard let target = possibleTargets.randomElement() else { return }
            sprite = SKSpriteNode(imageNamed: target)
            sprite.name = "target"
        } else {
            sprite = SKSpriteNode(imageNamed: "flake")
            sprite.name = "friend"
        }
        sprite.setScale(Double.random(in: 0.2 ... 0.4))
        sprite.position = CGPoint(x: Int.random(in: 50 ... 1000), y: 800)
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: 0, dy: -800)
        sprite.physicsBody?.angularVelocity = CGFloat(Int.random(in: 2 ... 4))
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        addChild(sprite)
    }

    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.y < -100 {
                node.removeFromParent()
            }
        }
    }
}
