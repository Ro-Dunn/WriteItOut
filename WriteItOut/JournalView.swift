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
                .background(Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6))
                .clipShape(Capsule())
                .foregroundColor(.white)
                
                Button("Breathe") {
                    finishEnabled.toggle()
                    showingSheet.toggle()
                }
                .frame(minWidth: 0, maxWidth: 100)
                .padding()
                .background(Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6))
                .clipShape(Capsule())
                .foregroundColor(.white)
                .sheet(isPresented: $showingSheet) {
                    SheetView(user: dummyUser, timeRemaining:user.breathingSelection.breatheIn )
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
    @State var animationCount = 0
    
    @AppStorage("rounds") private var rounds = 0
    @AppStorage("userIn") private var userIn = 0
    @AppStorage("userHold") private var userHold = 0
    @AppStorage("userOut") private var userOut = 0
    
    func setBreathe() {
        userIn = user.breathingSelection.breatheIn
        userHold = user.breathingSelection.breatheHold
        userOut = user.breathingSelection.breatheOut
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
                    .background(user.breathingSelection == sevenFourEight ? Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6) : Color(red: 0, green: 0, blue: 0.3).opacity(0.6))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    
                    
                    
                    
                    Button ("5-5-5") {
                        user.breathingSelection = fiveFiveFive
                        setBreathe()
                        
                    }
                    .padding()
                    .background(user.breathingSelection == fiveFiveFive ? Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6) : Color(red: 0, green: 0, blue: 0.3).opacity(0.6))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    
                    
                    Button ("4-7-4") {
                        user.breathingSelection = fourSevenFour
                        setBreathe()
                    }
                    .padding()
                    .background(user.breathingSelection == fourSevenFour ? Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6) : Color(red: 0, green: 0, blue: 0.3).opacity(0.6))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                }
            }
            Text("Duration")
            GroupBox {
                DisclosureGroup("Durration") {
                    Button("3 Rounds"){
                        rounds = 3
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: 300)
                    .background(rounds == 3 ? Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6) : Color(red: 0, green: 0, blue: 0.3).opacity(0.6))
                    
                    Button("5 Rounds"){
                        rounds = 5
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: 300)
                    .background(rounds == 5 ? Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6) : Color(red: 0, green: 0, blue: 0.3).opacity(0.6))
                    
                    Button("8 Rounds"){
                        rounds = 8
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: 300)
                    .background(rounds == 8 ? Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6) : Color(red: 0, green: 0, blue: 0.3).opacity(0.6))
                }
            }
        }
        .opacity(!settings ? 0 : 1)
        .zIndex(2)
        
        Button ("Start") {
            settings.toggle()
        }
        .padding(20)
        .background(Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6))
        .clipShape(Capsule())
        .foregroundColor(.white)
        .opacity(!settings ? 0 : 1)
        
        //Animation Stuff down here
        let timer = Timer.publish(every: 1.2, on: .main, in: .common).autoconnect()
        Text("\(timeRemaining)")
            .padding()
            .foregroundColor(.white)
            .background(Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6))
            .cornerRadius(40)
            .font(.title)
            .opacity(settings ? 0 : 1)
        
        Button ("\(currentState)") {
        }
        .frame(minWidth: 0, maxWidth: 300)
        .padding()
        .foregroundColor(.white)
        .background(Color(red: 0.1, green: 0, blue: 0.3).opacity(0.6))
        .cornerRadius(40)
        .font(.title)
        .zIndex(1)
        .opacity(settings ? 0 : 1)
        
        
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
                animationCount = timeRemaining
            } else if timeRemaining == 0 {
                if currentState == "In"{
                    currentState = "Hold"
                    timeRemaining = userHold
                } else if currentState == "Hold"{
                    currentState = "Out"
                    timeRemaining = userOut
                } else if currentState == "Out"{
                    rounds = rounds - 1
                    print(rounds)
                    if rounds > 0{
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
            
        }
    }
}


//struct JournalView_Previews: PreviewProvider {
//    static var previews: some View {
//        JournalView()
//    }
//}
