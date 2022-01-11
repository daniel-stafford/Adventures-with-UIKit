import SpriteKit

class GameScene: SKScene {
    // score visible on screen
    var gameScore: SKLabelNode!
    var slots = [WhackSlot]()
    // use observer for DRY code
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    // this is will decrease over the game
    var popupTime = 0.85
    var numRounds = 0

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        // set center in center
        background.position = CGPoint(x: 512, y: 384)
        // draw over everything not taking in account alpha
        background.blendMode = .replace
        // p[ace behind
        background.zPosition = -1
        addChild(background)

        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        // place center in bottom left
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)

        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }

        // create first enemey after one second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.createEnemy()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        // where they tapped
        let location = touch.location(in: self)
        // give us all sknodes at touch location
        let tappedNodes = nodes(at: location)

        for node in tappedNodes {
            // get grandparent (spriteNode, inside cropNode, inside WhackSlot class
            guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
            if !whackSlot.isVisible { continue }
            if whackSlot.isHit { continue }
            whackSlot.hit()

            if node.name == "charFriend" {
                // they shouldn't have whacked this penguin
                score -= 5
                // The three main sound file formats you'll use are MP3, M4A and CAF, with the latter being a renamed AIFF file. AIFF is a pretty terrible file format when it comes to file size, but it's much faster to load and use than MP3s and M4As, so you'll use them often.
                run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
            } else if node.name == "charEnemy" {
                // they should have whacked this one
                whackSlot.charNode.xScale = 0.85
                whackSlot.charNode.yScale = 0.85
                score += 1

                run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
            }
        }
    }

    func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }

    func createEnemy() {

        numRounds += 1

        if numRounds >= 30 {
            for slot in slots {
                slot.hide()
            }

            run(SKAction.playSoundFileNamed("gameOver.caf", waitForCompletion: false))
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)

            let FinalGameScore = SKLabelNode(fontNamed: "Chalkduster")
            FinalGameScore.text = "Your final score: \(score)"
            // place center in bottom left
            FinalGameScore.position = CGPoint(x: 512, y: 300)
//            FinalGameScore.horizontalAlignmentMode = .center
            FinalGameScore.fontSize = 48
            addChild(FinalGameScore)

            return
        }

        // speed up the game incrementally with every new enemy
        popupTime *= 0.991

        // pick random slow
        slots.shuffle()
        slots[0].show(hideTime: popupTime)

        // likely
        if Int.random(in: 0 ... 12) > 4 { slots[1].show(hideTime: popupTime) }
        if Int.random(in: 0 ... 12) > 8 { slots[2].show(hideTime: popupTime) }
        if Int.random(in: 0 ... 12) > 10 { slots[3].show(hideTime: popupTime) }
        // unliekly
        if Int.random(in: 0 ... 12) > 11 { slots[4].show(hideTime: popupTime) }

        // set random delay between bounds
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let delay = Double.random(in: minDelay ... maxDelay)

        // function calls itself after random delay from now
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.createEnemy()
        }
    }
}
