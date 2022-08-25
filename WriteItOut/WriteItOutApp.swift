//
//  WriteItOutApp.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/18/22.
//

import SwiftUI

@main
struct WriteItOutApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserJournal())
        }
    }
}
