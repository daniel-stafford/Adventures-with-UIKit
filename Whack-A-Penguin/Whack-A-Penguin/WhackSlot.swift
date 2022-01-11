//
//  WhackSlot.swift
//  Whack-A-Penguin
//
//  Created by Daniel Stafford on 1/10/22.
//

import SpriteKit
import UIKit

// T his base class doesn't draw images like sprites or hold text like labels; it just sits in our scene at a position, holding other nodes as children.
class WhackSlot: SKNode {
    var charNode: SKSpriteNode!
    var isVisible = false
    var isHit = false

    // no need for init, If you don't create any custom initializers (and don't have any non-optional properties) Swift will just use the parent class init() methods.
    func configure(at position: CGPoint) {
        self.position = position

        // has a hole
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)

        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
//        cropNode.maskNode = .nil
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")

        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        // If you want something to be cropped, it must be made a child of a crop node.
        cropNode.addChild(charNode)

        // has a penguin shaped crop node (for showing/hiding) that contains the penguin
        addChild(cropNode)
    }

    func show(hideTime: Double) {
        if isVisible { return }

        charNode.xScale = 1
        charNode.yScale = 1

        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        animateMud(isAppearing: true)
        isVisible = true
        isHit = false

        // 1 in 3 chance is good
        if Int.random(in: 0 ... 2) == 0 {
            // changing texture means not having to remove/add nodes
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }

        // hide after some time
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
            self?.hide()
        }
    }

    func hide() {
        if !isVisible { return }
        // move back down to hole
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
        
        animateMud(isAppearing: false)
        
    }

    func hit() {
        isHit = true

        // wait a quarter second
        let delay = SKAction.wait(forDuration: 0.25)
        // back into hole
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        // hide the penguin
        let notVisible = SKAction.run { [unowned self] in self.isVisible = false }
        // run wait, hiding, not visible in sequence

        charNode.run(SKAction.sequence([delay, hide, notVisible]))

        if let smokeParticles = SKEmitterNode(fileNamed: "smokeParticles.sks") {
            smokeParticles.position = charNode.position
            addChild(smokeParticles)
            fadeAndRemove(node: smokeParticles, duration: 1)
        }
    }
    
    func animateMud(isAppearing: Bool){
        if let mudParticles = SKEmitterNode(fileNamed: "mudParticles.sks") {
            if isAppearing {
                mudParticles.position = CGPoint(x: 0, y: charNode.position.y + 80)
            } else {
                
                mudParticles.position = CGPoint(x: 0, y: charNode.position.y + 10)
            }
            addChild(mudParticles)
            fadeAndRemove(node: mudParticles, duration: 0.1)
        }
    }

    func fadeAndRemove(node: SKNode, duration: TimeInterval) {
        let wait = SKAction.wait(forDuration: duration)
        let fadeOutAction = SKAction.fadeOut(withDuration: duration)
        let remove = SKAction.run({ node.removeFromParent }())
        let sequence = SKAction.sequence([wait, fadeOutAction, remove])
        node.run(sequence)
    }
}
