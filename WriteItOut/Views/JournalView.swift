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
    @Binding var rootIsActive : Bool
    @State var finishEnabled = true
    @State private var showingSheet = false
    @State var user:User
    
    var body: some View {
        ZStack{
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
                    NavigationLink(destination: SaveView(shouldPopToRootView: self.$rootIsActive, isWantingToShare: false, date: Date(), thisColorSelected: "SystemColor", colorSelected: false)) {
                        Text("Done")
                    }
                    .isDetailLink(false)
                    //                        .navigationBarTitle("Two")
                    .frame(minWidth: 0, maxWidth: 100)
                    .padding()
                    .background(Color("SystemColor"))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .onAppear{
                        finishEnabled = true
                    }
                    .toolbar {
                        ToolbarItem() {
                            Button("Breathe") {
                                finishEnabled.toggle()
                                showingSheet.toggle()
                            }
                            .sheet(isPresented: $showingSheet) {
                                SheetView(user: user, timeRemaining:user.breathingSelection.breatheIn )
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    
    
    struct SheetView: View {
        @Environment(\.dismiss) var dismiss
        @State var user:User
        @State var settings = true
        @AppStorage("currentState") var currentState = "In"
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
                if settings == true {
                    VStack{
                        HStack{
                            Button ("7-4-8") {
                                user.breathingSelection = sevenFourEight
                                userIn = 7
                                userHold = 4
                                userOut = 8
                                setBreathe()
                            }
                            .padding()
                            .background(userIn == sevenFourEight.breatheIn ? Color("SystemColor") : Color("SytemSelectedColor"))
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                            
                            Button ("5-5-5") {
                                user.breathingSelection = fiveFiveFive
                                userIn = 5
                                userHold = 5
                                userOut = 5
                                setBreathe()
                            }
                            .padding()
                            .background(userIn == fiveFiveFive.breatheIn ? Color("SystemColor") : Color("SytemSelectedColor"))
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                            
                            Button ("4-7-4") {
                                user.breathingSelection = fourSevenFour
                                userIn = 4
                                userHold = 7
                                userOut = 4
                                setBreathe()
                            }
                            .padding()
                            .background(userIn == fourSevenFour.breatheIn ? Color("SystemColor") : Color("SytemSelectedColor"))
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                            
                        }.padding(40)
                        HStack{
                            Button("3 Rounds"){
                                user.breathingRounds = threeRounds
                                userRounds = 3
                                setRounds()
                            }
                            .padding()
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: 150)
                            .background(userRounds == threeRounds.roundCount ? Color("SystemColor") : Color("SytemSelectedColor"))
                            .clipShape(Capsule())
                            
                            Button("5 Rounds"){
                                user.breathingRounds = fiveRounds
                                userRounds = 5
                                setRounds()
                            }
                            .padding()
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: 150)
                            .background(userRounds == fiveRounds.roundCount ? Color("SystemColor") : Color("SytemSelectedColor"))
                            .clipShape(Capsule())
                            
                            Button("8 Rounds"){
                                user.breathingRounds = eightRounds
                                userRounds = 8
                                setRounds()
                                
                            }
                            .padding()
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: 150)
                            .background(userRounds == eightRounds.roundCount ? Color("SystemColor") : Color("SytemSelectedColor"))
                            .clipShape(Capsule())
                            
                        }.padding(40)
                        VStack{
                            Button ("Start") {
                                settings.toggle()
                                timeRemaining = userIn
                                currentState = "In"
                                print(user.breathingSelection)
                                print(user.breathingRounds)
                            }
                            .padding(20)
                            .background(Color("SytemSelectedColor"))
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                            .opacity(!settings ? 0 : 1)
                        }.padding(40)
                    }
                } else {
                    VStack(spacing: 40){
                        
                        LottieView(lottieFile: "loader")
                            .frame(width: 300, height: 300)
                        
                        
                        
                        let timer = Timer.publish(every: 1.2, on: .main, in: .common).autoconnect()
                        Text("\(timeRemaining)")
                            .padding()
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
                    }
                }
            }
        }
    }
}





//struct JournalView_Previews: PreviewProvider {
//    static var previews: some View {
//        JournalView()
//    }
//}
