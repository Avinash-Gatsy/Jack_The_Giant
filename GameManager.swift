//
//  GameManager.swift
//  Jack The Giant
//
//  Created by Avinash on 03/04/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import Foundation

class GameManager {
    
    static let instance = GameManager()
    private init(){}
    
    var gameStartedFromMainMenu = false
    var gameRestartedPlayerDied = false
}
