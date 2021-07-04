//
//  GameScene.swift
//  SKPerfTest
//
//  Created by Christophe SAUVEUR on 04/07/2021.
//

import SpriteKit
import GameplayKit

class GameScene : SKScene {
    
    let movementComponentSystem = GKComponentSystem(componentClass: MovementComponent.self)
    var sprites: [SKTexture]
    
    var spriteNodeContainer: SKNode?
    
    var timeSinceLastSprite: TimeInterval = 0
    var lastUpdate: TimeInterval? = nil
    
    let limits: CGRect
    
    init(size: CGSize, useSingleAtlas: Bool) {
        sprites = [SKTexture]()
        
        limits = CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height)
        
        super.init(size: size)
        
        if (useSingleAtlas) {
            let singleAtlasTexture = SKTexture(imageNamed: "atlas")
            singleAtlasTexture.filteringMode = .nearest
            let spriteSize = 1.0 / 16.0
            let origin = CGPoint(x: 0, y: 0.5)
            for x in 0..<8 {
                for y in 0..<8 {
                    let spriteX = origin.x.native + Double(x) * spriteSize
                    let spriteY = origin.y.native + Double(y) * spriteSize
                    let sprite = SKTexture(rect: CGRect(x: spriteX, y: spriteY, width: spriteSize, height: spriteSize), in: singleAtlasTexture)
                    sprites.append(sprite)
                }
            }
        }
        else {
            for i in 0..<8 {
                let texture = SKTexture(imageNamed: "sprite_0\(i)")
                texture.filteringMode = .nearest
                sprites.append(texture)
            }
        }
        
        spriteNodeContainer = SKNode()
        addChild(spriteNodeContainer!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let localLastUpdate = lastUpdate else {
            lastUpdate = currentTime
            return
        }
        
        let timeDiff = currentTime - localLastUpdate
        lastUpdate = currentTime
        
        movementComponentSystem.update(deltaTime: timeDiff)
        
        timeSinceLastSprite += timeDiff
        if timeSinceLastSprite > 0.01 {
            let iterationCount = Int((timeSinceLastSprite / 0.01).rounded(.down))
            timeSinceLastSprite = 0
            
            let horizontalRange = limits.minX..<limits.maxX
            let verticalRange = limits.minY..<limits.maxY

            for _ in 0..<iterationCount {
                let x = CGFloat.random(in: horizontalRange)
                let y = CGFloat.random(in: verticalRange)

                let i = Int.random(in: 0..<sprites.count)
                let sprite = sprites[i]

                let node = SKSpriteNode(texture: sprite)
                node.position = CGPoint(x: x, y: y)
                spriteNodeContainer!.addChild(node)

                movementComponentSystem.addComponent(MovementComponent(limits: limits, node: node))
            }
        }
    }
    
}
