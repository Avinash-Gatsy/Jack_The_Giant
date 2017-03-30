//
//  Player.swift
//  Jack The Giant
//
//  Created by Avinash on 31/03/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    func initializePlayerAndAnimations(){
        //we get all the player images and store in the below textureAtlas variable
        textureAtlas = SKTextureAtlas(named: "Player.atlas") // check the Assets group
        
        //we start the loop from 2 as Player 1 is alreay the ideal one existing by default
        for i in 2...textureAtlas.textureNames.count{
           let name = "Player \(i)"
            //playerAnimation.append(textureAtlas.textureNamed(name))
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
    }
    func animatePlayer(moveLeft: Bool){
        //to change the direction of the player
        if moveLeft{
            self.xScale = -fabs(self.xScale) //fabs - absolute value
        } else {
            self.xScale = fabs(self.xScale)
        }
        
        //we need to repeat the action forever to simulate the animation else it will stop after one player image is changed
        //we need a key to access the animation and remove it when not required
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate")
    }
    func stopPlayerAnimation(){
        self.removeAction(forKey: "Animate")
        
        //resetting the player back to his original image
        self.texture = SKTexture(imageNamed: "Player 1")
        
        //avoids the change in player size after animation
        self.size = (self.texture?.size())!
    }
    
    func movePlayer(moveLeft: Bool){
        if moveLeft{
            self.position.x -= 7
        }else{
            self.position.x += 7
        }
    }
}
