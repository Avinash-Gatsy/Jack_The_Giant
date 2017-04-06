//
//  OptionScene.swift
//  Jack The Giant
//
//  Created by Avinash on 02/04/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    
    private var easyBtn:SKSpriteNode?
    private var mediumBtn:SKSpriteNode?
    private var hardBtn:SKSpriteNode?
    
    private var sign:SKSpriteNode?
    
    override func didMove(to view: SKView) {
        initializeVariables()
        setSign()
    }
    func initializeVariables(){
        easyBtn = self.childNode(withName: "Easy Button") as! SKSpriteNode
        mediumBtn = self.childNode(withName: "Medium Button") as! SKSpriteNode
        hardBtn = self.childNode(withName: "Hard Button") as! SKSpriteNode
        sign = self.childNode(withName: "Sign") as! SKSpriteNode
    }
    //setting the sign when we inititally go to the options scene
    func setSign(){
        if GameManager.instance.getEasyDifficulity() {
            sign?.position.y = (easyBtn?.position.y)!
        } else if GameManager.instance.getMediumDifficulity(){
            sign?.position.y = (mediumBtn?.position.y)!
        } else if GameManager.instance.getHardDifficulity(){
            sign?.position.y = (hardBtn?.position.y)!
        }
    }
    
    private func setDifficulity(difficulity: String){
        switch difficulity {
        case "easy":
            GameManager.instance.setEasyDifficulity(easyDifficulity: true)
            GameManager.instance.setMediumDifficulity(mediumDifficulity: false)
            GameManager.instance.setHardDifficulity(hardDifficulity: false)
            break
            
        case "medium":
            GameManager.instance.setEasyDifficulity(easyDifficulity: false)
            GameManager.instance.setMediumDifficulity(mediumDifficulity: true)
            GameManager.instance.setHardDifficulity(hardDifficulity: false)
            break
            
        case "hard":
            GameManager.instance.setEasyDifficulity(easyDifficulity: false)
            GameManager.instance.setMediumDifficulity(mediumDifficulity: false)
            GameManager.instance.setHardDifficulity(hardDifficulity: true)
            break
            
        default:
            break
        }
        GameManager.instance.saveData() //save the data
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            if node == easyBtn {
                sign?.position.y = (easyBtn?.position.y)!
                setDifficulity(difficulity: "easy")
            }
            if node == mediumBtn {
                sign?.position.y = (mediumBtn?.position.y)!
                setDifficulity(difficulity: "medium")
            }
            if node == hardBtn {
                sign?.position.y = (hardBtn?.position.y)!
                setDifficulity(difficulity: "hard")
            }
            sign?.zPosition = 4
            
            if node.name == "Back"{
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene?.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1))
            }
        }
    }
}
