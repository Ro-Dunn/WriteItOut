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
                        .background(.blue)
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
