//
//  ColorMap.swift
//  WriteItOut
//
//  Created by Katy Dunn on 9/1/22.
//

import SwiftUI
import Foundation

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

struct ColorMap: View {
    @Environment(\.managedObjectContext) var moc
    
    @State public var colorSelected:Bool
    @State public var thisColorSelected:String //dailyColor.color
    @State public var dateOfEntry:Date = Date()
    @State public var df = DateFormatter() //going to be dailyColor.dateString (Must return it as a date converted to a string)
    
    var body: some View {
        VStack{
            Circle()
                .fill(colorSelected == true ? Color("\(thisColorSelected)") : Color("SystemColor"))
                .frame(width: 100, height: 100)
            Divider()
            Spacer()
            
            VStack {
                Divider()
                ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach (feelingArray) { feeling in
                            CircleView(label: feeling)
                                .onTapGesture {
                                    colorSelected = true
                                    thisColorSelected = feeling
                                }
                        }
                        
                    }.padding()
                }.frame(height: 100)
                Divider()
            }
            
            
            Button("Save") {
                let newColorData = DailyColor(context: moc)
                df.dateStyle = DateFormatter.Style.short
                newColorData.dateString = (df.string(from: dateOfEntry))
                newColorData.color = thisColorSelected
                print(newColorData)
                //save the date to colorData
                try? moc.save()
            }
            .frame(minWidth: 0, maxWidth: 100)
            .padding()
            .background(Color("SystemColor"))
            .clipShape(Capsule())
            .foregroundColor(.white)
            
        }
    }
}

struct ColorMap_Previews: PreviewProvider {
    static var previews: some View {
        ColorMap(colorSelected: false, thisColorSelected: "SystemColor", dateOfEntry: Date())
    }
}
