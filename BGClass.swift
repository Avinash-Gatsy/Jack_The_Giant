//
//  BGClass.swift
//  Jack The Giant
//
//  Created by Avinash on 01/04/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode{
    //function to reposition the BGs
    func moveBG(camera: SKCameraNode){
        //check if the BG is completely out of view 
        if self.position.y - self.size.height - 10 > camera.position.y{
            //since we have 3 BG images in scene we just multiple the y pos by 3 to bring 1st one after 3rd one
            self.position.y -= self.size.height * 3
        }
    }
}
