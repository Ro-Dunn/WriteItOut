//
//  ContentView.swift
//  WriteItOut
//
//  Created by Ro Dunn on 8/18/22.
//

import SwiftUI

struct ContentView: View {
    @State var user: User
    var body: some View {
        NavigationView {
            VStack {
                if user.name != "User" {
                    Text("Welcome Back \(user.name)")
                        .padding()
                } else {
                    Text("Set up your profile by clicking the User button.")
                        .padding()
                }
                
                NavigationLink(destination: JournalView()) {
                    Text("Start")
                    .frame(minWidth: 0, maxWidth: 300)
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(40)
                    .font(.title)
            }
                //Button ("Color Map") {
                // print("Color Map Pressed")
                //}
            }
            .toolbar {
                NavigationLink(destination: UserView(user: user)) {
                    Text("User")
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: dummyUser)
    }
}
