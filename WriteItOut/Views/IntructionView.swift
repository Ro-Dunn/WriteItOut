//
//  IntructionView.swift
//  WriteItOut
//
//  Created by Katy Dunn on 10/3/22.
//

import SwiftUI

struct IntructionView: View {
    var body: some View {
        ZStack{
            bohemianBackground(backgroundTracker: 1)
                .opacity(0.35)
            VStack{
                Text("Write It Out")
                    .bold()
                Text("""
            This app is a journaling app and a mood tracker.
            
            Take time to decompress by writing away your worries or doing breathing exercises. Both can be found through the journaling button on the main page. When you've finished an entry it won't be saved by the app. This is done to promote writing without having to worry about entries quality. Feel free to take the text with you though.
            
            Luckily, though your entries won't be saved, there is also the color map to help track mood, you can make an entry at any time through the button on the main page or when you finish an entry. Each entry will be displayed with the date and the corrisponding 'feeling' or color.
            """)
            }
            .frame(minWidth: 0, maxWidth: 350)
        }
    }
}

struct IntructionView_Previews: PreviewProvider {
    static var previews: some View {
        IntructionView()
    }
}
