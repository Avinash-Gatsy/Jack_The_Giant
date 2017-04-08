//
//  CollectablesController.swift
//  Jack The Giant
//
//  Created by Avinash on 04/04/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import SpriteKit

class CollectablesController{
    
    func getCollectable() -> SKSpriteNode {
        
        var collectable = SKSpriteNode()
        //print(GameplayController.instance.life!)
        
        //lower the value to spawn more life
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 7)) >= 5 && GameplayController.instance.life! < 2 {
            
            if GameplayController.instance.life! < 2 {
                //spawn a life 
                collectable = SKSpriteNode(imageNamed: "Life")
                collectable.name = "Life"
                collectable.physicsBody = SKPhysicsBody(rectangleOf: collectable.size)
            } else {
                //we need to name the collectable if our above check fails
                //if we dont giv  a name it will throw a nil exception in checkForChildsOutOffScreen() when we are seperating the name wrt " "
                collectable.name = "Empty"
            }
            
        } else {
            
            //spawn a coin
            collectable = SKSpriteNode(imageNamed: "Coin")
            collectable.name = "Coin"
            collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
            
        }
        
        collectable.physicsBody?.affectedByGravity = false
        collectable.physicsBody?.categoryBitMask = colliderType.DarkCloudAndCollectables //note the contactTestBitMask for player is the same
        collectable.physicsBody?.collisionBitMask = colliderType.Player
        collectable.zPosition = 2 //to make sure its rendered on top of the BG
        
        return collectable
    }
    //random number between 2 numbers
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
