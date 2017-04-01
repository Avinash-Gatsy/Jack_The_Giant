//
//  GameplayScene.swift
//  Jack The Giant
//
//  Created by Avinash on 31/03/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var mainCamera: SKCameraNode?
    
    var bg1:BGClass?
    var bg2:BGClass?
    var bg3:BGClass?
    
    var player: Player?
    var canMove = false
    var moveLeft = false
    var center: CGFloat?
    
    override func didMove(to view: SKView) {
       initializeVariables()
    }
    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
    }
    func initializeVariables(){
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        player = (self.childNode(withName: "Player") as! Player)
        
        //childNode(withName: "Main Camera") will get the child with a specific name from the scene
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode!
        
        //once we get the player we initialize player and animations
        player?.initializePlayerAndAnimations()
        
        getBackgorounds()
    }
    func getBackgorounds(){
        bg1 = self.childNode(withName: "BG 1") as?  BGClass!
        bg2 = self.childNode(withName: "BG 2") as?  BGClass!
        bg3 = self.childNode(withName: "BG 3") as?  BGClass!
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if location.x > center!{
                moveLeft = false
                player?.animatePlayer(moveLeft: moveLeft)
            }else{
                moveLeft = true
                player?.animatePlayer(moveLeft: moveLeft)
            }
        }
        canMove = true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    func managePlayer(){
        if canMove{
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
    func moveCamera(){
        // we will move the camera only in the y direction
        // depending on the level of the player we can pace up the movement of camera downward
        self.mainCamera?.position.y -= 3
    }
    func manageBackgrounds(){
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
}
