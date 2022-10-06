//
//  ContentView.swift
//  WriteItOut
//
//  Created by Ro Dunn on 8/18/22.
//

import SwiftUI
import CoreData
import AVKit

struct ContentView: View {
    @EnvironmentObject var user:User
    @State var now = Date()//the current date
    @State public var df = DateFormatter()
    @State var isActive : Bool = false
    
    
    var body: some View {
        NavigationView {
            ZStack{
                bohemianBackground(backgroundTracker: 0)
                VStack {
                    Text("Welcome Back").font(Font.custom("Futura-MediumItalic", size: 30))
                        .padding()
                        .foregroundColor(Color("FeelingCalm"))
                    
                    NavigationLink(
                        destination: JournalView(rootIsActive: self.$isActive, user: user),
                        isActive: self.$isActive
                    ) {
                        Text("Journal").font(Font.custom("Futura-Bold", size: 30))
                    }
                    .isDetailLink(false)
                    //                .navigationBarTitle("Root")
                    .frame(minWidth: 0, maxWidth: 300)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("SystemColor"))
                    .cornerRadius(40)
                    .font(.title)
                    
                    NavigationLink(destination: ColorMap(colorSelected: false, thisColorSelected: "SystemColor", dateOfEntry: Date(), noneToday: true)) {
                        Text("Color Map")
                            .font(Font.custom("Futura-Bold", size: 30))
                            .frame(minWidth: 0, maxWidth: 300)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("SystemColor"))
                            .cornerRadius(40)
                            .font(.title)
                    }
                    NavigationLink(destination: IntructionView()) {
                        Text("Instructions")
                            .padding(.top)
                            .frame(alignment: .bottom)
                    }
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SetReminders() ) {
                            Text("Set Reminders").font(Font.custom("Futura", size: 21))
                        }
                    }
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
