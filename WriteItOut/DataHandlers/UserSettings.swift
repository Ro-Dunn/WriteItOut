//
//  UserSettings.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/31/22.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    
    @Published var userRounds: Int {
        didSet {
            UserDefaults.standard.set(userRounds, forKey: "userRounds")
        }
    }
    
    @Published var userPatternIn: Int {
        didSet {
            UserDefaults.standard.set(userPatternIn, forKey: "userIn")
        }
    }
    
    @Published var userPatternHold: Int {
        didSet {
            UserDefaults.standard.set(userPatternHold, forKey: "userHold")
        }
    }
    
    @Published var userPatternOut: Int {
        didSet {
            UserDefaults.standard.set(userPatternOut, forKey: "userOut")
        }
    }
    
    init() {
        self.userRounds = UserDefaults.standard.object(forKey: "userRounds") as? Int ?? 3
        self.userPatternIn = UserDefaults.standard.object(forKey: "userIn") as? Int ?? 5
        self.userPatternHold = UserDefaults.standard.object(forKey: "userHold") as? Int ?? 5
        self.userPatternOut = UserDefaults.standard.object(forKey: "userOut") as? Int ?? 5
    }
    
    func saveData(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userRounds) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "userRounds")
        }
        
        if let encoded = try? encoder.encode(userPatternIn) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "userIn")
        }
        
        if let encoded = try? encoder.encode(userPatternHold) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "userHold")
        }
        
        if let encoded = try? encoder.encode(userPatternOut) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "userOut")
        }
    }
    
}
