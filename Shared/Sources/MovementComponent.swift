//
//  MovementComponent.swift
//  SKPerfTest
//
//  Created by Christophe SAUVEUR on 04/07/2021.
//

import GameplayKit
import SpriteKit

class MovementComponent : GKComponent {
    
    let limits: CGRect
    let node: SKNode
    let speed: CGFloat
    var movingRight: Bool
    var movingUp: Bool
    
    init(limits: CGRect, node: SKNode) {
        self.limits = limits
        self.node = node
        
        speed = CGFloat.random(in: 5..<20)
        
        movingRight = Bool.random()
        movingUp = Bool.random()
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        let offset = speed * CGFloat(seconds)

        var newPositionX = node.position.x
        if movingRight {
            newPositionX += offset
            if newPositionX > limits.maxX {
                newPositionX = limits.maxX - (newPositionX - limits.maxX)
                movingRight = false
            }
        }
        else {
            newPositionX -= offset
            if newPositionX < limits.minX {
                newPositionX = limits.minX + (limits.minX - newPositionX)
                movingRight = true
            }
        }

        var newPositionY = node.position.y
        if movingUp {
            newPositionY += offset
            if newPositionY > limits.maxY {
                newPositionY = limits.maxY - (newPositionY - limits.maxY)
                movingUp = false
            }
        }
        else {
            newPositionY -= offset
            if newPositionY < limits.minY {
                newPositionY = limits.minY + (limits.minY - newPositionY)
                movingUp = true
            }
        }

        node.position = CGPoint(x: newPositionX, y: newPositionY)
        
    }
    
}
