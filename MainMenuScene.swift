//
//  MainMenuScene.swift
//  Jack The Giant
//
//  Created by Avinash on 02/04/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    //var highscoreBtn: SKSpriteNode?
    
    override func didMove(to view: SKView) {
       //highscoreBtn = self.childNode(withName: "Highscore") as? SKSpriteNode!
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self) //find the touch location
            let node : SKNode = self.atPoint(location)  //find the node at the location
            
            //check for the name of the node as we mentioned in sks scene, we can use either of the below conditions
            if node.name == "Highscore" {
                
                //navigate to the HighscoreScene
                let scene = HighscoreScene(fileNamed: "HighscoreScene")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
            //note if we are using the check by the name, then we dont need the refrence to the buttons
//            if node == highscoreBtn{
//                print("high score btn is pressed")
//            }
            if node.name == "Option" {
                
                //navigate to the HighscoreScene
                let scene = OptionScene(fileNamed: "OptionScene")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
            if node.name == "Start Game" {
                
                //navigate to the HighscoreScene
                let scene = GameplayScene(fileNamed: "GameplayScene")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
        }
    }
}
