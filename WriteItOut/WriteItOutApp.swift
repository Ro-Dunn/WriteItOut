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
        }
    }
}
