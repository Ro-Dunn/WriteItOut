//
//  BreathingView.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/22/22.
//
//
//import SwiftUI
//
//struct BreathingView: View {
//
//    @State private var user: User
//    @State private var currentState:Int = 0
//    @State private var timeRemaining = 3
//
//    let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
//
//    var breathingExercise:BreathingPattern {
//        user.breathingSelection
//    }
//
//    var body: some View {
//
//        VStack{
//
//            Text("Let's Breathe")
//
//            Text("0\(timeRemaining)")
//                .font(.largeTitle)
//                .foregroundColor(.white)
//                .padding(.horizontal, 20)
//                .padding(.vertical, 5)
//                .background(.blue.opacity(0.75))
//                .clipShape(Capsule())
//        }
//        .onReceive(timer) { time in
//            currentState = Int(timeRemaining)
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//            } else if timeRemaining == 0 {
//                timeRemaining = breathingExercise.getUpNext(current: currentState)
//            }
//        }
//
//
//
//    }//end body
//
//
//}
//
//struct BreathingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BreathingView(user: dummyUser, currentState: , timeRemaining: <#T##arg#>)
//    }
//}
