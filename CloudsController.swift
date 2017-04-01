//
//  CloudsController.swift
//  Jack The Giant
//
//  Created by Avinash on 01/04/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import SpriteKit

class CloudsController{
    
    //store the last cloud position y
    var lastCloudPosY = CGFloat()
    
    //function to randomize the position of clouds
    func shuffle(cloudsArray: [SKSpriteNode]) -> [SKSpriteNode]{
        
        var cloudsArray = cloudsArray
        for i in (1...cloudsArray.count - 1).reversed() {
            
           //gives a random number upto i - 1
            let j = Int(arc4random_uniform(UInt32(i - 1)))
            //swapping the position of clouds in the cloudsArray
            swap(&cloudsArray[i], &cloudsArray[j])
        }
        return cloudsArray
        
    }
    
    //random number between 2 numbers
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        //arc4random returns a number between 0 to (2**32)-1
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    //A function to create an array of SKSpriteNodes
    func createClouds() -> [SKSpriteNode]{
      var clouds = [SKSpriteNode]()
        
        for i in 0..<2 {
            let cloud1 = SKSpriteNode(imageNamed: "Cloud 1")
            cloud1.name = "1"
            let cloud2 = SKSpriteNode(imageNamed: "Cloud 2")
            cloud2.name = "2"
            let cloud3 = SKSpriteNode(imageNamed: "Cloud 3")
            cloud3.name = "3"
            
            let darkCloud = SKSpriteNode(imageNamed: "Dark Cloud")
            darkCloud.name = "Dark Cloud"
            
            cloud1.setScale(0.9)
            cloud2.setScale(0.9)
            cloud3.setScale(0.9)
            darkCloud.setScale(0.9)
            
            //add physics body to the clouds
            
            clouds.append(cloud1)
            clouds.append(cloud2)
            clouds.append(cloud3)
            clouds.append(darkCloud)
            
            
        }
        clouds = shuffle(cloudsArray: clouds)
        return clouds
    }
    //the arguments we pass in the below function 
    //scene-GameplayScene
    //distanceBetweenClouds - its the distance between then in y axis
    //initialClouds - to check the clouds during the start of the game 
    
    func arrangeCloudsInScene(scene: SKScene, distanceBetweenClouds: CGFloat, center: CGFloat, minX: CGFloat, maxX: CGFloat, initialClouds: Bool){
        
        var clouds = createClouds()
        
        if initialClouds{
            while (clouds[0].name == "Dark Cloud") {
                //shuffle the cloud array
                clouds = shuffle(cloudsArray: clouds)
            }
        }
        
        var positionY = CGFloat()
        
        if initialClouds{
            positionY = center - 150
        }else{
            positionY = lastCloudPosY
        }
        
        var random = 0
        
        for i in 0...clouds.count - 1 {
            
            var randomX = CGFloat()
            if random == 0{
                randomX = randomBetweenNumbers(firstNum: center + 65, secondNum: maxX)
                random = 1
            } else {
                randomX = randomBetweenNumbers(firstNum: center - 65, secondNum: minX)
                random = 0
            }
            
            clouds[i].position = CGPoint(x: randomX, y: positionY)
            clouds[i].zPosition = 3
            scene.addChild(clouds[i])
            
            //reposition the clouds
            positionY -= distanceBetweenClouds
            lastCloudPosY = positionY
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
