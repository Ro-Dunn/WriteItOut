//
//  BreathingPatterns.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/18/22.
//

import Foundation


struct breathingPattern:Hashable {
    var breatheIn: Int
    var breatheHold: Int
    var breatheOut: Int
}


let sevenFourEight = breathingPattern(breatheIn: 7, breatheHold: 4, breatheOut: 8)

let fiveFiveFive = breathingPattern(breatheIn: 5, breatheHold: 5, breatheOut: 5)

let fourSevenFour = breathingPattern(breatheIn: 4, breatheHold: 7, breatheOut: 4)


let breathingArray: [breathingPattern] = [sevenFourEight, fiveFiveFive, fourSevenFour]
