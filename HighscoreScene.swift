//
//  HighscoreScene.swift
//  Jack The Giant
//
//  Created by Avinash on 02/04/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import SpriteKit

class HighscoreScene: SKScene{
    
    private var highScoreLabel:SKLabelNode?
    private var coinScoreLabel:SKLabelNode?
    
    override func didMove(to view: SKView) {
        initializeVariables()
        setScore()
    }
    private func initializeVariables(){
        highScoreLabel = self.childNode(withName: "Score Label") as? SKLabelNode
        coinScoreLabel = self.childNode(withName: "Coin Label") as? SKLabelNode
    }
    //setting the score labels
    private func setScore(){
        if GameManager.instance.getEasyDifficulity() == true {
            highScoreLabel?.text = "\(GameManager.instance.getEasyDifficulityScore())"
            coinScoreLabel?.text = String(GameManager.instance.getEasyDifficulityCoinScore())
        } else if GameManager.instance.getMediumDifficulity() == true {
            highScoreLabel?.text = "\(GameManager.instance.getMediumDifficulityScore())"
            coinScoreLabel?.text = String(GameManager.instance.getMediumDifficulityCoinScore())
        } else if GameManager.instance.getHardDifficulity() == true {
            highScoreLabel?.text = "\(GameManager.instance.getHardDifficulityScore())"
            coinScoreLabel?.text = String(GameManager.instance.getHardDifficulityCoinScore())
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            if node.name == "Back"{
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene?.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1))
            }
        }
    }
}
