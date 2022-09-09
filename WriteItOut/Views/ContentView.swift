//
//  ContentView.swift
//  WriteItOut
//
//  Created by Ro Dunn on 8/18/22.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var user:User
    @State var doMap = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome Back")
                    .padding()
                
                NavigationLink(destination: JournalView(user: user)) {
                    Text("Start")
                        .frame(minWidth: 0, maxWidth: 300)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("SystemColor"))
                        .cornerRadius(40)
                        .font(.title)
                }
                
                NavigationLink(destination: ColorMap(colorSelected: false, thisColorSelected: "SystemColor", dateOfEntry: Date(), noneToday: doMap)) {
                    Text("Color Map")
                        .frame(minWidth: 0, maxWidth: 300)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("SystemColor"))
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
