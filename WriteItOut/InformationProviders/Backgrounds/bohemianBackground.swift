//
//  bohemianBackground.swift
//  WriteItOut
//
//  Created by Katy Dunn on 9/23/22.
//

import SwiftUI

struct bohemianBackground: View {
    @State var backgroundTracker:Int
    var body: some View {
        if  backgroundTracker == 0 {
            Image("palePinkTanAbstract")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .edgesIgnoringSafeArea(.bottom)
        } else if  backgroundTracker == 1 {
            Image("grayBlueAbstract")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .edgesIgnoringSafeArea(.bottom)
        } else if  backgroundTracker == 2 {
            Image("grayWhiteOffWhiteAbstract")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}
