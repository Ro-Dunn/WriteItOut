//
//  ContentView.swift
//  WriteItOut
//
//  Created by Ro Dunn on 8/18/22.
//

import SwiftUI


struct ContentView: View {
    //    @State var user: User
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome Back.")
                    .padding()
                
                NavigationLink(destination: JournalView()) {
                    Text("Start")
                        .frame(minWidth: 0, maxWidth: 300)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6))
                        .cornerRadius(40)
                        .font(.title)
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
