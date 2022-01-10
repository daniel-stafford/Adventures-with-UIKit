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
        cropNode.addChild(charNode)

        // has a penguin shaped crop node (for showing/hiding) that contains the penguin
        addChild(cropNode)
    }

    func show(hideTime: Double) {
        if isVisible { return }

        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
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
        //move back down to hole
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
}
