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

    override func didMove(to view: SKView) {
        backgroundColor = .black

        starfield = SKEmitterNode(fileNamed: "starfield")!
        //right end, halfway up
        starfield.position = CGPoint(x: 1024, y: 384)
        //prefill screen with starfield (move 10 seconds worth of starts)
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
    }

    override func update(_ currentTime: TimeInterval) {
    }
}
