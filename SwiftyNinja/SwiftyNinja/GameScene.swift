//
//  GameScene.swift
//  SwiftyNinja
//
//  Created by Daniel Stafford on 1/20/22.
//

import SpriteKit
// allows us to stop sounds
import AVFoundation

class GameScene: SKScene {
    enum ForceBomb {
        case never, always, random
    }

    var gameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }

    var livesImages = [SKSpriteNode]()
    var lives = 3

    var activeSliceBG: SKShapeNode!
    var activeSliceFG: SKShapeNode!

    var activeSlicePoints = [CGPoint]()

    var isSwooshSoundActive = false
    var bombSoundEffect: AVAudioPlayer?

    var activeEnemies = [SKSpriteNode]()

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "sliceBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        // earth default -9.8, so perhaps moon gravity?
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        // everything happens at slight slower rate
        physicsWorld.speed = 0.85

        createScore()
        createLives()
        createSlices()
    }

    func createScore() {
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)

        gameScore.position = CGPoint(x: 8, y: 8)
        score = 0
    }

    func createLives() {
        for i in 0 ..< 3 {
            let spriteNode = SKSpriteNode(imageNamed: "sliceLife")
            // use i * 70 to bump right each time
            spriteNode.position = CGPoint(x: CGFloat(834 + (i * 70)), y: 720)
            addChild(spriteNode)

            livesImages.append(spriteNode)
        }
    }

    func createSlices() {
        // SKShapeNode for shapes!
        activeSliceBG = SKShapeNode()
        activeSliceBG.zPosition = 2

        activeSliceFG = SKShapeNode()
        activeSliceFG.zPosition = 3

        activeSliceBG.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
        activeSliceBG.lineWidth = 9

        activeSliceFG.strokeColor = UIColor.white
        activeSliceFG.lineWidth = 5

        addChild(activeSliceBG)
        addChild(activeSliceFG)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        // 1 Ditch all prior slice points
        activeSlicePoints.removeAll(keepingCapacity: true)

        // 2 Append new location just like touchMoved
        let location = touch.location(in: self)
        activeSlicePoints.append(location)

        // 3
        redrawActiveSlice()

        // 4 Important - remove fade out action
        activeSliceBG.removeAllActions()
        activeSliceFG.removeAllActions()

        // 5 Now alpha won't conflict with disabled fade out action
        activeSliceBG.alpha = 1
        activeSliceFG.alpha = 1
    }

    func redrawActiveSlice() {
        // 1 If only one slice, not enough to make line, exit method
        if activeSlicePoints.count < 2 {
            activeSliceBG.path = nil
            activeSliceFG.path = nil
            return
        }

        // 2 Track max 12 slices (stops from being too long)
        if activeSlicePoints.count > 12 {
            // remove as many to get to 12
            activeSlicePoints.removeFirst(activeSlicePoints.count - 12)
        }

        // 3 start path on first slice on screen
        let path = UIBezierPath()
        path.move(to: activeSlicePoints[0])

        // move path to point of next slice
        for i in 1 ..< activeSlicePoints.count {
            path.addLine(to: activeSlicePoints[i])
        }

        // 4 Assign path to our shape nodes
        activeSliceBG.path = path.cgPath
        activeSliceFG.path = path.cgPath
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        // add touch to slice array
        activeSlicePoints.append(location)
        redrawActiveSlice()
        if !isSwooshSoundActive {
            playSwooshSound()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // slice fades out after quarter second
        activeSliceBG.run(SKAction.fadeOut(withDuration: 0.25))
        activeSliceFG.run(SKAction.fadeOut(withDuration: 0.25))
    }

    func playSwooshSound() {
        isSwooshSoundActive = true

        // play one of three sounds
        let randomNumber = Int.random(in: 1 ... 3)
        let soundName = "swoosh\(randomNumber).caf"

        let swooshSound = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)

        // completion closure tells game no longer playing
        run(swooshSound) { [weak self] in
            self?.isSwooshSoundActive = false
        }
    }

    // as random most of time, use as default argument
    func createEnemy(forceBomb: ForceBomb = .random) {
        let enemy: SKSpriteNode

        var enemyType = Int.random(in: 0 ... 6)

        if forceBomb == .never {
            enemyType = 1
        } else if forceBomb == .always {
            enemyType = 0
        }

        if enemyType == 0 {
            // 1 make a bomb, using SKSpirteNode
            enemy = SKSpriteNode()
            // bomb always in front
            enemy.zPosition = 1
            enemy.name = "bombContainer"

            // 2
            let bombImage = SKSpriteNode(imageNamed: "sliceBomb")
            bombImage.name = "bomb"
            enemy.addChild(bombImage)

            // 3 Ensure sound effect played from scratch
            if bombSoundEffect != nil {
                bombSoundEffect?.stop()
                bombSoundEffect = nil
            }

            // 4
            if let path = Bundle.main.url(forResource: "sliceBombFuse", withExtension: "caf") {
                if let sound = try? AVAudioPlayer(contentsOf: path) {
                    bombSoundEffect = sound
                    sound.play()
                }
            }

            // 5
            if let emitter = SKEmitterNode(fileNamed: "sliceFuse") {
                emitter.position = CGPoint(x: 76, y: 64)
                enemy.addChild(emitter)
            }
        } else {
            // make penguin
            enemy = SKSpriteNode(imageNamed: "penguin")
            run(SKAction.playSoundFileNamed("launch.caf", waitForCompletion: false))
            enemy.name = "enemy"
        }

        // position section!
        // starting random position at bottom of screen
        let randomPosition = CGPoint(x: Int.random(in: 64 ... 960), y: -128)
        enemy.position = randomPosition

        // 2 Angular movement for enemy
        let randomAngularVelocity = CGFloat.random(in: -3 ... 3)
        let randomXVelocity: Int

        // 3. If position on  far left, move to far right
        if randomPosition.x < 256 {
            randomXVelocity = Int.random(in: 8 ... 15)
            // 3. If slightly on left, gently right
        } else if randomPosition.x < 512 {
            randomXVelocity = Int.random(in: 3 ... 5)
        } else if randomPosition.x < 768 {
            randomXVelocity = -Int.random(in: 3 ... 5)
        } else {
            randomXVelocity = -Int.random(in: 8 ... 15)
        }

        // 4 Again, using "magic number", trial and error
        let randomYVelocity = Int.random(in: 24 ... 32)

        // 5 config velocity, spin
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: 64)
        enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * 40, dy: randomYVelocity * 40)
        enemy.physicsBody?.angularVelocity = randomAngularVelocity
        // enemies won't bounce into each other
        enemy.physicsBody?.collisionBitMask = 0

        addChild(enemy)
        activeEnemies.append(enemy)
    }

    
    override func update(_ currentTime: TimeInterval) {
        var bombCount = 0

        for node in activeEnemies {
            //get all bombs
            if node.name == "bombContainer" {
                bombCount += 1
                // only need to know at least one bomb exists
                break
            }
        }
        if bombCount == 0 {
            // no bombs – stop the fuse sound!
            bombSoundEffect?.stop()
            bombSoundEffect = nil
        }
    }
}
