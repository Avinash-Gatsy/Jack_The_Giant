//
//  OptionScene.swift
//  Jack The Giant
//
//  Created by Avinash on 02/04/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    override func didMove(to view: SKView) {
        
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
