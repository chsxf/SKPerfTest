//
//  GameView.swift
//  Tetris
//
//  Created by Christophe SAUVEUR on 04/03/2021.
//

import SpriteKit

class GameView: SKView {

    override init(frame frameRect: CGRect) {
        super.init(frame: frameRect)

        showsFPS = true
        showsDrawCount = true
        showsNodeCount = true
        
        let scene = GameScene(size: frameRect.size, useSingleAtlas: true)
        
        let cam = SKCameraNode()
        cam.position = CGPoint(x: 0, y: 0)
        scene.camera = cam
        scene.addChild(cam)
        
        presentScene(scene)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
