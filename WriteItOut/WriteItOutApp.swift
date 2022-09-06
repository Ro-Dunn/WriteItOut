//
//  WriteItOutApp.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/18/22.
//

import SwiftUI

@main
struct WriteItOutApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(UserJournal())
                .environmentObject(UserSettings())
                .environmentObject(User(breathingSelection:BreathingPattern.init(
                    breatheIn: UserDefaults.standard.integer(forKey: "userIn"),
                    breatheHold: UserDefaults.standard.integer(forKey: "userHold"),
                    breatheOut: UserDefaults.standard.integer(forKey: "userOut")),
                    breathingRounds:rounds.init(roundCount: UserDefaults.standard.integer(forKey: "userRounds")
                    ))
                )
        }
    }
}
