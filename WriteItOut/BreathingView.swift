//
//  BreathingView.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/22/22.
//

import SwiftUI

struct BreathingView: View {
    @State var user: User
    @State private var timeRemaining = 3
    var body: some View {
        let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
        let breathingExercise = user.breathingSelection
        
        let beginCountDown = 3
        
        VStack{
            
            Text("Let's Breathe")
            
            Text("0\(timeRemaining)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(.blue.opacity(0.75))
                .clipShape(Capsule())
        }
        .onReceive(timer) { time in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else if timeRemaining == 0 {
                
            }
        }
    }
}

struct BreathingView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingView(user: dummyUser)
    }
}