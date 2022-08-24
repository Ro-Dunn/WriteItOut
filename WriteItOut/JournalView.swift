//
//  JournalView.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/19/22.
//

import SwiftUI
import UIKit

struct JournalView: View {
    @State var userJournal = ""
    @State var wordCount:Int = 0
    
    var body: some View {
        VStack {
            Text("\(wordCount)")
                .multilineTextAlignment(.trailing)
            
            TextEditor(text: $userJournal)
                .font(.body)
                .padding()
                .padding(.top, 20)
                .onChange(of: userJournal) { value in
                    let words = userJournal.split { $0 == " " || $0.isNewline }
                    self.wordCount = words.count
                }
            
            NavigationLink(destination: BreathingView(user: dummyUser) ) {
                Text("Finish")
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


struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
