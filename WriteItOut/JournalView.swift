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
//                .environmentObject(currentJournal)
                
                Button("Breathe") {
                    finishEnabled.toggle()
                    showingSheet.toggle()
                }
                .disabled(!finishEnabled)
                .padding()
                .sheet(isPresented: $showingSheet) {
                    SheetView(user: dummyUser)
                }
                .onAppear{
                    finishEnabled = true
                }
            }
        }
    }
}



struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var user:User
    
    var body: some View {
        VStack{
            VStack{
                Text("Current Pattern")
                HStack{
                    Button ("7-4-8") {
                        user.breathingSelection = sevenFourEight
                        
                        print("748 Pressed! Users pattern is now \(user.breathingSelection)")
                    }
                    .padding()
                    .background(Color(red: 0, green: 0, blue: 0.3))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    
                    
                    
                    Button ("5-5-5") {
                        user.breathingSelection = fiveFiveFive
                        
                        print("555 pressed! Users pattern is now \(user.breathingSelection)")
                    }
                    .padding()
                    .background(Color(red: 0, green: 0, blue: 0.3))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    
                    
                    
                    Button ("4-7-4") {
                        user.breathingSelection = fourSevenFour
                        
                        print("474 Pressed! Users pattern is now \(user.breathingSelection)")
                    }
                    .padding()
                    .background(Color(red: 0, green: 0, blue: 0.3))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                }
            }
            Text("Duration")
            GroupBox {
                DisclosureGroup("Durration") {
                    Button("3 Rounds"){
                        user.breathingRounds = 3
                    }
                    .padding()
                    Button("5 Rounds"){
                        user.breathingRounds = 5
                        
                    }
                    .padding()
                    Button("8 Rounds"){
                        user.breathingRounds = 8
                    }
                    .padding()
                }
            }
            
            //Color Map Display
        }
    }
}





struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
