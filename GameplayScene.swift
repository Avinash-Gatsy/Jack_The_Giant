//
//  GameplayScene.swift
//  Jack The Giant
//
//  Created by Avinash on 31/03/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var cloudsController = CloudsController()
    var mainCamera: SKCameraNode?
    
    var bg1:BGClass?
    var bg2:BGClass?
    var bg3:BGClass?
    
    var player: Player?
    var canMove = false
    var moveLeft = false
    var center: CGFloat?
    
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    
    let distanceBetweenClouds = CGFloat(200)
    let minX = CGFloat(-104.7)
    let maxX = CGFloat(104.7)
    
    private var pausePanel: SKSpriteNode?
    override func didMove(to view: SKView) {
       initializeVariables()
    }
    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        createNewClouds()
    }
    func initializeVariables(){
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        player = (self.childNode(withName: "Player") as! Player)
        
        //childNode(withName: "Main Camera") will get the child with a specific name from the scene
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode!
        
        //once we get the player we initialize player and animations
        player?.initializePlayerAndAnimations()
        
        getBackgorounds()
        getLabels()
        
        //after we get the labels we need to initialize the variables
        GameplayController.instance.initializeVariables()
        
        cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: true)
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 350
    }
    func getBackgorounds(){
        bg1 = self.childNode(withName: "BG 1") as?  BGClass!
        bg2 = self.childNode(withName: "BG 2") as?  BGClass!
        bg3 = self.childNode(withName: "BG 3") as?  BGClass!
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            
            //animate the payer and move only if the scene is not paused
            if self.scene?.isPaused == false{
                if location.x > center!{
                    moveLeft = false
                    player?.animatePlayer(moveLeft: moveLeft)
                }else{
                    moveLeft = true
                    player?.animatePlayer(moveLeft: moveLeft)
                }
            }
            
            if node.name == "Pause"{
                //to pause the game when the overlay is showed
                self.scene?.isPaused = true
                createPausePanel()
            }
            if node.name == "Resume"{
                //remove the pausePanel 
                pausePanel?.removeFromParent()
                self.scene?.isPaused = false
            }
            if node.name == "Quit"{
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene?.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1))
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
        self.mainCamera?.position.y -= 2.5
    }
    func manageBackgrounds(){
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
    func createNewClouds(){
        if cameraDistanceBeforeCreatingNewClouds > (mainCamera?.position.y)! {
            cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 350
            
            cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: false)
        }
    }
    func getLabels(){
        //note all the nodes below are child of main camera and not the scene
        
        GameplayController.instance.scoreText = self.mainCamera?.childNode(withName: "Score Text") as? SKLabelNode!
        GameplayController.instance.coinText = self.mainCamera?.childNode(withName: "Coin Score") as? SKLabelNode!
        GameplayController.instance.lifeText = self.mainCamera?.childNode(withName: "Life Score") as? SKLabelNode!
        
    }
    
    func createPausePanel(){
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        let resumeBtn = SKSpriteNode(imageNamed: "Resume Button")
        let quitBtn = SKSpriteNode(imageNamed: "Quit Button 2")
        
        pausePanel?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pausePanel?.setScale(1.3)
        pausePanel?.zPosition = 5 //we have the zPosition for player to be 4, we need to render the pause panel on top of everything else
        
        pausePanel?.position = CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.height)! / 2)
        
        resumeBtn.name = "Resume"
        resumeBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        resumeBtn.zPosition = 6
        resumeBtn.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! + 25)
        
        quitBtn.name = "Quit"
        quitBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quitBtn.zPosition = 6
        quitBtn.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! - 45)
        
        pausePanel?.addChild(resumeBtn)
        pausePanel?.addChild(quitBtn)
        
        self.mainCamera?.addChild(pausePanel!)
        
    }
}

