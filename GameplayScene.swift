//
//  GameplayScene.swift
//  Jack The Giant
//
//  Created by Avinash on 31/03/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var cloudsController = CloudsController()
    var mainCamera: SKCameraNode?
    
    var bg1:BGClass?
    var bg2:BGClass?
    var bg3:BGClass?
    
    var player: Player?
    var canMove = false
    var moveLeft = false
    var center: CGFloat?
    
    private var acceleration = CGFloat()
    private var cameraSpeed = CGFloat()
    private var maxSpeed = CGFloat()
    
    private let playerMinX = CGFloat(-165)
    private let playerMaxX = CGFloat(165)
    
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    
    let distanceBetweenClouds = CGFloat(250)
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
        player?.setScore()
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        //making the firstBody to be the Player
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Life"{
            //play the sound for life
            
            //increment the life and score
            GameplayController.instance.incrementLife()
            
            //remove the life from scene
            secondBody.node?.removeFromParent()
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            //play the coin sound
            
            //increment coin and score
            GameplayController.instance.incrementCoin()
            
            secondBody.node?.removeFromParent()
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Cloud" {
            //kill the player
            self.scene?.isPaused = true
            GameplayController.instance.life! -= 1
            
            if GameplayController.instance.life! >= 0 {
                GameplayController.instance.lifeText?.text = "x\(GameplayController.instance.life!)"
            } else {
                //show end score panel
                createEndScorePanel()
            }
            firstBody.node?.removeFromParent() //remove the player when he is kiled
            
            //delay the playerDied function call after the player is removed
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2.0), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
            
            //playerDied()
            
        }
    }
    
    func initializeVariables(){
        physicsWorld.contactDelegate = self // we will handle the physics on contact
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -7.5) //changing the value of gravity
        
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
        
        setCameraSpeed()
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
        if (player?.position.x)! < playerMinX{
            player?.position.x = playerMinX
        }
        if (player?.position.x)! > playerMaxX {
            player?.position.x = playerMaxX
        }
        if (player?.position.y)! - (player?.size.height)! * 3.2 > (mainCamera?.position.y)! {
            print("the player is out of bounds up")
            self.scene?.isPaused = true //pause the scene
            
            GameplayController.instance.life! -= 1
            
            if GameplayController.instance.life! >= 0 {
                GameplayController.instance.lifeText?.text = "x\(GameplayController.instance.life!)"
            } else {
                //show end score panel
                createEndScorePanel()
            }
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2.0), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
        }
        if (player?.position.y)! + (player?.size.height)! * 3.2 < (mainCamera?.position.y)! {
            print("the player is out of bounds down")
            self.scene?.isPaused = true //pause the scene
            
            GameplayController.instance.life! -= 1
            
            if GameplayController.instance.life! >= 0 {
                GameplayController.instance.lifeText?.text = "x\(GameplayController.instance.life!)"
            } else {
                //show end score panel
                createEndScorePanel()
            }
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2.0), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
        }
    }
    func moveCamera(){
        // we will move the camera only in the y direction
        // depending on the level of the player we can pace up the movement of camera downward
        //self.mainCamera?.position.y -= 3.0
        
        //camera speed to be dynamic based on difficulity lvl
        cameraSpeed += acceleration
        if cameraSpeed > maxSpeed {
            cameraSpeed = maxSpeed
        }
        mainCamera?.position.y -= cameraSpeed
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
            
            //whenever we create new clouds we will remove the ones which are out of the screen
            checkForChildsOutOffScreen()
        }
    }
    func checkForChildsOutOffScreen(){
        for child in children{
            
            if child.position.y > (mainCamera?.position.y)! + (self.scene?.size.height)!{
                
                //note we cannot directly remove the child here as it includes our BG as well
                let childName = child.name?.components(separatedBy: " ")
                
                if childName?[0] != "BG"{
                    //print("The child that was removed is \(child.name!)")
                    child.removeFromParent()
                }
            }
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
    func createEndScorePanel() {
        let endScorePanel = SKSpriteNode(imageNamed: "Show Score")
        let scoreLabel = SKLabelNode(fontNamed: "Blow")
        let coinLabel = SKLabelNode(fontNamed: "Blow")
        
        endScorePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        endScorePanel.zPosition = 8 //render on top of everything
        endScorePanel.setScale(1.0)
        
        scoreLabel.fontSize = 48
        scoreLabel.zPosition = 7
        
        coinLabel.fontSize = 48
        coinLabel.zPosition = 7
        
        scoreLabel.text = "\(GameplayController.instance.score!)"
        coinLabel.text = "\(GameplayController.instance.coin!)"
        
        endScorePanel.addChild(scoreLabel)
        endScorePanel.addChild(coinLabel)
        
        endScorePanel.position = CGPoint(x: (mainCamera?.frame.size.width)! / 2, y: (mainCamera?.frame.height)! / 2)
        scoreLabel.position = CGPoint(x: endScorePanel.position.x, y: endScorePanel.position.y)
        coinLabel.position = CGPoint(x: endScorePanel.position.x, y: endScorePanel.position.y - 100)
        
        mainCamera?.addChild(endScorePanel)
    }
    private func setCameraSpeed() {
        if GameManager.instance.getEasyDifficulity(){
            acceleration = 0.001
            cameraSpeed = 2.0
            maxSpeed = 3.5
        } else if GameManager.instance.getMediumDifficulity(){
            acceleration = 0.002
            cameraSpeed = 2.5
            maxSpeed = 3.75
        } else if GameManager.instance.getHardDifficulity(){
            acceleration = 0.0025
            cameraSpeed = 3.0
            maxSpeed = 4.25
        }
    }
    func playerDied(){
        if GameplayController.instance.life! >= 0{
            GameManager.instance.gameRestartedPlayerDied = true
            let scene = GameplayScene(fileNamed: "GameplayScene")
            scene?.scaleMode = .aspectFill
            self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
        } else {
            if GameManager.instance.getEasyDifficulity() {
                
                let highScore = GameManager.instance.getEasyDifficulityScore()
                let coinScore = GameManager.instance.getEasyDifficulityCoinScore()
                
                if highScore < GameplayController.instance.score! {
                    GameManager.instance.setEasyDifficulityScore(easyDifficulityScore: GameplayController.instance.score!)
                }
                if coinScore < GameplayController.instance.coin! {
                    GameManager.instance.setEasyDifficulityCoinScore(easyDifficulityCoinScore: GameplayController.instance.coin!)
                }
                
                } else if GameManager.instance.getMediumDifficulity(){
                    
                    let highScore = GameManager.instance.getMediumDifficulityScore()
                    let coinScore = GameManager.instance.getMediumDifficulityCoinScore()
                    
                    if highScore < GameplayController.instance.score! {
                        GameManager.instance.setMediumDifficulityScore(mediumDifficulityScore: GameplayController.instance.score!)
                    }
                    if coinScore < GameplayController.instance.coin! {
                        GameManager.instance.setMediumDifficulityCoinScore(mediumDifficulityCoinScore: GameplayController.instance.coin!)
                    }
                    
                } else if GameManager.instance.getHardDifficulity(){
                        
                        let highScore = GameManager.instance.getHardDifficulityScore()
                        let coinScore = GameManager.instance.getHardDifficulityCoinScore()
                        
                        if highScore < GameplayController.instance.score! {
                            GameManager.instance.setHardDifficulityScore(hardDifficulityScore: GameplayController.instance.score!)
                        }
                        if coinScore < GameplayController.instance.coin! {
                            GameManager.instance.setHardDifficulityCoinScore(hardDifficulityCoinScore: GameplayController.instance.coin!)
                    }
                }
                GameManager.instance.saveData()
            
            //reload the main menu after saving the game data
            let scene = MainMenuScene(fileNamed: "MainMenuScene")
            scene?.scaleMode = .aspectFill
            
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1))
        }
    }
}

