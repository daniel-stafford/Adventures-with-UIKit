//
//  GameScene.swift
//  ShootingGallery
//
//  Created by Daniel Stafford on 1/16/22.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "landscape")
        // set center in center
        background.position = CGPoint(x: 512, y: 384)
        // draw over everything not taking in account alpha
        background.blendMode = .replace
        // p[ace behind
        background.zPosition = -1
        addChild(background)
    }
}
