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

    // no need for init, If you don't create any custom initializers (and don't have any non-optional properties) Swift will just use the parent class init() methods.
    func configure(at position: CGPoint) {
        self.position = position

        //has a hole
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
   
}
