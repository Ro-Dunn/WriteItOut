//
//  ContentView.swift
//  WriteItOut
//
//  Created by Ro Dunn on 8/18/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button ("Start") {
                    print("Start Pressed")
                }
                //Button ("Color Map") {
                // print("Color Map Pressed")
                //}
            }
            .toolbar {
                NavigationLink(destination: UserView(user:dummyUser)) {
                    Text("User")
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
