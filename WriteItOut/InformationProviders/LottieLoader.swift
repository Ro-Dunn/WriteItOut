//
//  GIFView.swift
//  WriteItOut
//
//  Created by Katy Dunn on 9/27/22.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    @EnvironmentObject var user: User
    let lottieFile: String
    let animationView = AnimationView()
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = Animation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        animationView.loopMode = .loop
        
        if user.breathingSelection == fiveFiveFive{
        
        animationView.animationSpeed = 0.55
            
        } else if user.breathingSelection == sevenFourEight{
            //get value from appStorage tracker
            
        } else if user.breathingSelection == fourSevenFour {
            
        }
        
        
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

