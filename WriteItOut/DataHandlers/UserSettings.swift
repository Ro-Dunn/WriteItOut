//
//  UserSettings.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/31/22.
//

import Foundation
import Combine

class UserSettings: ObservableObject{
    
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
    
    @Published var userEntryToday: String {
        didSet {
            UserDefaults.standard.set(userEntryToday, forKey: "entryToday")
        }
    }
    
    @Published var didUserEntryToday: Bool {
        didSet {
            UserDefaults.standard.set(userEntryToday, forKey: "didEntryToday")
        }
    }
    
    init() {
        self.userRounds = UserDefaults.standard.object(forKey: "userRounds") as? Int ?? 3
        self.userPatternIn = UserDefaults.standard.object(forKey: "userIn") as? Int ?? 5
        self.userPatternHold = UserDefaults.standard.object(forKey: "userHold") as? Int ?? 5
        self.userPatternOut = UserDefaults.standard.object(forKey: "userOut") as? Int ?? 5
        self.userEntryToday = UserDefaults.standard.object(forKey: "entryToday") as? String ?? "1/1/03"
        self.didUserEntryToday = UserDefaults.standard.object(forKey: "didEntryToday") as? Bool ?? true
    }
}
