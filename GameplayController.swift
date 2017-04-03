//
//  GameplayController.swift
//  Jack The Giant
//
//  Created by Avinash on 03/04/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import Foundation
import SpriteKit

class GameplayController {
    static let instance = GameplayController()
    
    //using the private init we will not be allowing any other class to create and instance of GameplayController
    private init(){}
    
    var scoreText: SKLabelNode?
    var coinText: SKLabelNode?
    var lifeText: SKLabelNode?
    
    var score: Int?
    var coin: Int?
    var life: Int?
    
    func initializeVariables(){
        if GameManager.instance.gameStartedFromMainMenu{
            
            GameManager.instance.gameStartedFromMainMenu = false
            
            score = 0
            coin = 0
            life = 2
            
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coin!)"
            lifeText?.text = "x\(life!)"
            
        } else if GameManager.instance.gameRestartedPlayerDied{
            
            GameManager.instance.gameRestartedPlayerDied = false
            
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coin!)"
            lifeText?.text = "x\(life!)"
            
        }
    }
}
