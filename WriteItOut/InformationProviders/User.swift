//
//  User.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/18/22.
//

import Foundation

class User:ObservableObject, Codable{
    var breathingSelection: BreathingPattern
    
    var breathingRounds: rounds
    
    init(breathingSelection: BreathingPattern, breathingRounds: rounds) {
        self.breathingSelection = breathingSelection
        self.breathingRounds = breathingRounds
    }
}


