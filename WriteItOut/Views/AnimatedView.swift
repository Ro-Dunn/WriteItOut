//
//  AnimatedView.swift
//  WriteItOut
//
//  Created by Katy Dunn on 9/27/22.
//

import SwiftUI

struct AnimatedView: View {
    var body: some View {
        LottieView(lottieFile: "loader")
            .frame(width: 300, height: 300)
    }
}

struct AnimatedView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedView()
    }
}
