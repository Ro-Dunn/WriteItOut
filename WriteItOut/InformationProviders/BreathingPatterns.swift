//
//  BreathingPatterns.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/18/22.
//

import Foundation

extension BreathingPattern {
    func getUpNext(current:Int) -> Int {
        var upNext:Int
        
        if current == breatheIn {
            upNext = breatheHold
            return upNext
            
        } else if current == breatheHold {
            upNext = breatheOut
            return upNext
            
        } else if current == breatheOut {
            upNext = breatheIn
            return upNext
        }
        
        return 0
    }
    
}

struct BreathingPattern: Equatable, Codable{
    var breatheIn: Int
    var breatheHold: Int
    var breatheOut: Int
}

struct rounds: Equatable, Codable{
    var roundCount:Int
}

let sevenFourEight = BreathingPattern(breatheIn: 7, breatheHold: 4, breatheOut: 8)

let fiveFiveFive = BreathingPattern(breatheIn: 5, breatheHold: 5, breatheOut: 5)

let fourSevenFour = BreathingPattern(breatheIn: 4, breatheHold: 7, breatheOut: 4)

let breathingArray: [BreathingPattern] = [sevenFourEight, fiveFiveFive, fourSevenFour]

var threeRounds = rounds(roundCount: 3)

var fiveRounds = rounds(roundCount: 5)

var eightRounds = rounds(roundCount: 8)
