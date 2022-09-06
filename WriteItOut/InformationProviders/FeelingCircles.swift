//
//  FeelingCircles.swift
//  WriteItOut
//
//  Created by Katy Dunn on 9/2/22.
//

import Foundation
import SwiftUI
import UIKit

struct CircleView: View {
    @State var label: String
    var body: some View {
        ZStack {
            Circle()
                .fill(Color("\(label)"))
                .frame(width: 70, height: 70)
        }
    }
}
