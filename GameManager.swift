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
    
    private var gameData: GameData?
    
    var gameStartedFromMainMenu = false
    var gameRestartedPlayerDied = false
    
    func initializeGameData(){
        if !FileManager.default.fileExists(atPath: getFilePath() as String){
            //setup our game with initial values
            gameData = GameData()
            
            gameData?.setEasyDifficulityScore(easyDifficulityScore: 0)
            gameData?.setEasyDifficulityCoinScore(easyDifficulityCoinScore: 0)
            gameData?.setMediumDifficulityScore(mediumDifficulityScore: 0)
            gameData?.setMediumDifficulityCoinScore(mediumDifficulityCoinScore: 0)
            gameData?.setHardDifficulityScore(hardDifficulityScore: 0)
            gameData?.setHardDifficulityCoinScore(hardDifficulityCoinScore: 0)
            
            gameData?.setEasyDifficulity(easyDifficulity: true)
            gameData?.setMediumDifficulity(mediumDifficulity: false)
            gameData?.setHardDifficulity(hardDifficulity: false)
            gameData?.setIsMusicOn(isMusicOn: false)
            
            saveData() //save the initial data
        }
        loadData()
    }
    
    //the required init?(coder aDecoder: NSCoder) in GameData class will automatically be called by NSKeyedUnarchiver and we can get all the data
    func loadData(){
        gameData = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath() as String) as? GameData
    }
    
    //the encode(with aCoder: NSCoder) in GameData class will automatically be called by NSKeyedArchiver to save our data
    func saveData(){
        if gameData != nil {
            NSKeyedArchiver.archiveRootObject(gameData, toFile: getFilePath() as String)
        }
    }
    
    private func getFilePath() -> String {
        let manager = FileManager.default
        //getting the first element from below [URL]
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        return (url?.appendingPathComponent("Game Data").path)!
        print(getFilePath())
    }
    
    //getters and setters
    func setEasyDifficulityScore(easyDifficulityScore: Int32){
        self.gameData?.setEasyDifficulityScore(easyDifficulityScore: easyDifficulityScore)
    }
    func getEasyDifficulityScore() -> Int32 {
        return (self.gameData?.getEasyDifficulityScore())!
    }
    func setMediumDifficulityScore(mediumDifficulityScore: Int32){
        self.gameData?.setMediumDifficulityScore(mediumDifficulityScore: mediumDifficulityScore)
    }
    func getMediumDifficulityScore() -> Int32 {
        return (self.gameData?.getMediumDifficulityScore())!
    }
    func setHardDifficulityScore(hardDifficulityScore: Int32){
        self.gameData?.setHardDifficulityScore(hardDifficulityScore: hardDifficulityScore)
    }
    func getHardDifficulityScore() -> Int32 {
        return (self.gameData?.getHardDifficulityScore())!
    }
    func setEasyDifficulityCoinScore(easyDifficulityCoinScore: Int32){
        self.gameData?.setEasyDifficulityCoinScore(easyDifficulityCoinScore: easyDifficulityCoinScore)
    }
    func getEasyDifficulityCoinScore() -> Int32 {
        return (self.gameData?.getEasyDifficulityCoinScore())!
    }
    func setMediumDifficulityCoinScore(mediumDifficulityCoinScore: Int32){
        self.gameData?.setMediumDifficulityCoinScore(mediumDifficulityCoinScore: mediumDifficulityCoinScore)
    }
    func getMediumDifficulityCoinScore() -> Int32 {
        return (self.gameData?.getMediumDifficulityCoinScore())!
    }
    func setHardDifficulityCoinScore(hardDifficulityCoinScore: Int32){
        self.gameData?.setHardDifficulityCoinScore(hardDifficulityCoinScore: hardDifficulityCoinScore)
    }
    func getHardDifficulityCoinScore() -> Int32 {
        return (self.gameData?.getHardDifficulityCoinScore())!
    }
    func setEasyDifficulity(easyDifficulity: Bool){
        self.gameData?.setEasyDifficulity(easyDifficulity: easyDifficulity)
    }
    func getEasyDifficulity() -> Bool {
        return (self.gameData?.getEasyDifficulity())!
    }
    func setMediumDifficulity(mediumDifficulity: Bool){
        self.gameData?.setMediumDifficulity(mediumDifficulity: mediumDifficulity)
    }
    func getMediumDifficulity() -> Bool {
        return (self.gameData?.getMediumDifficulity())!
    }
    func setHardDifficulity(hardDifficulity: Bool){
        self.gameData?.setHardDifficulity(hardDifficulity: hardDifficulity)
    }
    func getHardDifficulity() -> Bool {
        return (self.gameData?.getHardDifficulity())!
    }
    func IsMusicOn(isMusicOn:Bool){
        self.gameData?.setIsMusicOn(isMusicOn: isMusicOn)
    }
    func getIsMusicOn() -> Bool {
        return (self.gameData?.getIsMusicOn())!
    }
}
