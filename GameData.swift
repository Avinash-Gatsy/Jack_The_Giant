//
//  GameData.swift
//  Jack The Giant
//
//  Created by Avinash on 05/04/17.
//  Copyright © 2017 avinash. All rights reserved.
//

import Foundation

class GameData: NSObject, NSCoding {
    
    struct Keys {
        static let EasyDifficulityScore = "EasyDifficulityScore"
        static let MediumDifficulityScore = "MediumDifficulityScore"
        static let HardDifficulityScore = "HardDifficulityScore"
        
        static let EasyDifficulityCoinScore = "EasyDifficulityCoinScore"
        static let MediumDifficulityCoinScore = "MediumDifficulityCoinScore"
        static let HardDifficulityCoinScore = "HardDifficulityCoinScore"
        
        static let EasyDifficulity = "EasyDifficulity"
        static let MediumDifficulity = "MediumDifficulity"
        static let HardDifficulity = "HardDifficulity"
        
        static let Music = "Music"
    }
    
    private var easyDifficulityScore = Int32()
    private var mediumDifficulityScore = Int32()
    private var hardDifficulityScore = Int32()
    
    private var easyDifficulityCoinScore = Int32()
    private var mediumDifficulityCoinScore = Int32()
    private var hardDifficulityCoinScore = Int32()
    
    private var easyDifficulity = false
    private var mediumDifficulity = false
    private var hardDifficulity = false
    
    private var isMusicOn = false
    
    override init() {
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        //load the data
        
        self.easyDifficulityScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficulityScore)
        self.easyDifficulityCoinScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficulityCoinScore)
        
        self.mediumDifficulityScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficulityScore)
        self.mediumDifficulityCoinScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficulityCoinScore)
        
        self.hardDifficulityScore = aDecoder.decodeInt32(forKey: Keys.HardDifficulityScore)
        self.hardDifficulityCoinScore = aDecoder.decodeInt32(forKey: Keys.HardDifficulityCoinScore)
        
        self.easyDifficulity = aDecoder.decodeBool(forKey: Keys.EasyDifficulity)
        self.mediumDifficulity = aDecoder.decodeBool(forKey: Keys.MediumDifficulity)
        self.hardDifficulity = aDecoder.decodeBool(forKey: Keys.HardDifficulity)
        
        self.isMusicOn = aDecoder.decodeBool(forKey: Keys.Music)
    }
    func encode(with aCoder: NSCoder) {
        //save the data
        aCoder.encode(self.easyDifficulityScore, forKey: Keys.EasyDifficulityScore)
        aCoder.encode(self.easyDifficulityCoinScore, forKey: Keys.EasyDifficulityCoinScore)
        
        aCoder.encode(self.mediumDifficulityScore, forKey: Keys.MediumDifficulityScore)
        aCoder.encode(self.mediumDifficulityCoinScore, forKey: Keys.MediumDifficulityCoinScore)
        
        aCoder.encode(self.hardDifficulityScore, forKey: Keys.HardDifficulityScore)
        aCoder.encode(self.hardDifficulityCoinScore, forKey: Keys.HardDifficulityCoinScore)
        
        aCoder.encode(self.easyDifficulity, forKey: Keys.EasyDifficulity)
        aCoder.encode(self.mediumDifficulity, forKey: Keys.MediumDifficulity)
        aCoder.encode(self.hardDifficulity, forKey: Keys.HardDifficulity)
        
        aCoder.encode(self.isMusicOn, forKey: Keys.Music)
        
    }
    //since the variables are private we need to have the getters and setters
    
    func setEasyDifficulityScore(easyDifficulityScore: Int32){
        self.easyDifficulityScore = easyDifficulityScore
    }
    func setEasyDifficulityCoinScore(easyDifficulityCoinScore: Int32){
        self.easyDifficulityCoinScore = easyDifficulityCoinScore
    }
    func getEasyDifficulityScore() -> Int32 {
        return self.easyDifficulityScore
    }
    func getEasyDifficulityCoinScore() -> Int32 {
        return self.easyDifficulityCoinScore
    }
    func setMediumDifficulityScore(mediumDifficulityScore: Int32){
        self.mediumDifficulityScore = mediumDifficulityScore
    }
    func setMediumDifficulityCoinScore(mediumDifficulityCoinScore: Int32){
        self.mediumDifficulityCoinScore = mediumDifficulityCoinScore
    }
    func getMediumDifficulityScore() -> Int32 {
        return self.mediumDifficulityScore
    }
    func getMediumDifficulityCoinScore() -> Int32 {
        return self.mediumDifficulityCoinScore
    }
    func setHardDifficulityScore(hardDifficulityScore: Int32){
        self.hardDifficulityScore = hardDifficulityScore
    }
    func setHardDifficulityCoinScore(hardDifficulityCoinScore: Int32){
        self.hardDifficulityCoinScore = hardDifficulityCoinScore
    }
    func getHardDifficulityScore() -> Int32 {
        return self.hardDifficulityScore
    }
    func getHardDifficulityCoinScore() -> Int32 {
        return self.hardDifficulityCoinScore
    }
    func setEasyDifficulity(easyDifficulity: Bool){
        self.easyDifficulity = easyDifficulity
    }
    func getEasyDifficulity() -> Bool{
        return self.easyDifficulity
    }
    func setMediumDifficulity(mediumDifficulity: Bool){
        self.mediumDifficulity = mediumDifficulity
    }
    func getMediumDifficulity() -> Bool{
        return self.mediumDifficulity
    }
    func setHardDifficulity(hardDifficulity: Bool){
        self.hardDifficulity = hardDifficulity
    }
    func getHardDifficulity() -> Bool{
        return self.hardDifficulity
    }
    func setIsMusicOn(isMusicOn: Bool){
        self.isMusicOn = isMusicOn
    }
    func getIsMusicOn() -> Bool{
        return self.isMusicOn
    }
    
}
