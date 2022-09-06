//
//  JournalView.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/19/22.
//

import SwiftUI
import UIKit


class UserJournal: ObservableObject {
    @Published var currentJournal = ""
}

struct JournalView: View {
    @EnvironmentObject var userJournal: UserJournal
    @State var wordCount:Int = 0
    @State var finishEnabled = true
    @State private var showingSheet = false
    @State var user:User
    
    var body: some View {
        VStack {
            Text("\(wordCount)")
                .multilineTextAlignment(.trailing)
            
            TextEditor(text: $userJournal.currentJournal)
                .font(.body)
                .padding()
                .padding(.top, 20)
                .onChange(of: userJournal.currentJournal) { value in
                    let words = userJournal.currentJournal.split { $0 == " " || $0.isNewline }
                    self.wordCount = words.count
                }
                .onAppear{
                    userJournal.currentJournal = ""
                }
            HStack{
                NavigationLink(destination: SaveView()) {
                    Text("Done")
                }
                .frame(minWidth: 0, maxWidth: 100)
                .padding()
                .background(Color("SystemColor"))
                .clipShape(Capsule())
                .foregroundColor(.white)
                
                Button("Breathe") {
                    finishEnabled.toggle()
                    showingSheet.toggle()
                }
                .frame(minWidth: 0, maxWidth: 100)
                .padding()
                .background(Color("SystemColor"))
                .clipShape(Capsule())
                .foregroundColor(.white)
                .sheet(isPresented: $showingSheet) {
                    SheetView(user: user, timeRemaining:user.breathingSelection.breatheIn )
                }
                .onAppear{
                    finishEnabled = true
                }
            }
            .padding()
        }
    }
}



struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var user:User
    @State var settings = true
    @State var currentState = "In"
    @State var timeRemaining:Int
    
    //    @AppStorage("rounds") private var rounds = 0
    @State private var userRounds = UserDefaults.standard.integer(forKey: "userRounds")
    @State private var userIn = UserDefaults.standard.integer(forKey: "userIn")
    @State private var userHold = UserDefaults.standard.integer(forKey: "userHold")
    @State private var userOut = UserDefaults.standard.integer(forKey: "userOut")

    func setBreathe() {
        UserDefaults.standard.set(self.userIn, forKey: "userIn")
        UserDefaults.standard.set(self.userHold, forKey: "userHold")
        UserDefaults.standard.set(self.userOut, forKey: "userOut")
    }
    
    func setRounds() {
        UserDefaults.standard.set(self.userRounds, forKey: "userRounds")
    }
    
    var body: some View {
        VStack{
            VStack{
                Text("Current Pattern")
                    .opacity(!settings ? 0 : 1)
                HStack{
                    Button ("7-4-8") {
                        user.breathingSelection = sevenFourEight
                        setBreathe()
                    }
                    .padding()
                    .background(user.breathingSelection == sevenFourEight ? Color("SystemColor") : Color("SytemSelectedColor"))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    
                    
                    
                    
                    Button ("5-5-5") {
                        user.breathingSelection = fiveFiveFive
                        setBreathe()
                        
                    }
                    .padding()
                    .background(user.breathingSelection == fiveFiveFive ? Color("SystemColor") : Color("SytemSelectedColor"))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    
                    
                    Button ("4-7-4") {
                        user.breathingSelection = fourSevenFour
                        setBreathe()
                    }
                    .padding()
                    .background(user.breathingSelection == fourSevenFour ? Color("SystemColor") : Color("SytemSelectedColor"))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                }
            }
            Text("Duration")
            GroupBox {
                DisclosureGroup("Durration") {
                    Button("3 Rounds"){
                        user.breathingRounds = threeRounds
                        setRounds()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: 300)
                    .background(user.breathingRounds == threeRounds ? Color("SystemColor") : Color("SytemSelectedColor"))
                    
                    Button("5 Rounds"){
                        user.breathingRounds = fiveRounds
                        setRounds()
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: 300)
                    .background(user.breathingRounds == fiveRounds ? Color("SystemColor") : Color("SytemSelectedColor"))
                    
                    Button("8 Rounds"){
                        user.breathingRounds = eightRounds
                        setRounds()
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: 300)
                    .background(user.breathingRounds == eightRounds ? Color("SystemColor") : Color("SytemSelectedColor"))
                }
            }
        }
        .opacity(!settings ? 0 : 1)
        .zIndex(2)
        
        Button ("Start") {
            settings.toggle()
            timeRemaining = userIn
            print(user.breathingSelection)
            print(user.breathingRounds)
        }
        .padding(20)
        .background(Color("SystemColor"))
        .clipShape(Capsule())
        .foregroundColor(.white)
        .opacity(!settings ? 0 : 1)
        
        //Animation Stuff down here
        let timer = Timer.publish(every: 1.2, on: .main, in: .common).autoconnect()
        Text("\(timeRemaining)")
            .padding()
            .foregroundColor(.white)
            .background(Color("SystemColor"))
            .cornerRadius(40)
            .font(.title)
            .opacity(settings ? 0 : 1)
        
        Button ("\(currentState)") {
        }
        .frame(minWidth: 0, maxWidth: 300)
        .padding()
        .foregroundColor(.white)
        .background(Color("SystemColor"))
        .cornerRadius(40)
        .font(.title)
        .zIndex(1)
        .opacity(settings ? 0 : 1)
        
        
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else if timeRemaining == 0 {
                if currentState == "In"{
                    currentState = "Hold"
                    timeRemaining = userHold
                } else if currentState == "Hold"{
                    currentState = "Out"
                    timeRemaining = userOut
                } else if currentState == "Out"{
                    userRounds = userRounds - 1
                    print(userRounds)
                    if userRounds > 0{
                        currentState = "In"
                        timeRemaining = userIn
                    } else {
                        currentState = "Done"
                        timeRemaining = 0
                    }
                }
            }
        }
        .onAppear{
            print(user.breathingSelection)
        }
    }
}


//struct JournalView_Previews: PreviewProvider {
//    static var previews: some View {
//        JournalView()
//    }
//}
