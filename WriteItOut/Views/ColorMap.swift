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
    @EnvironmentObject var dataController:DataController
    @Environment(\.managedObjectContext) var moc

    @FetchRequest var daliy: FetchedResults<DailyColor>

    @State public var colorSelected:Bool
    @State public var thisColorSelected:String //dailyColor.color
    @State public var dateOfEntry:Date = Date()
    @State public var df = DateFormatter() //going to be dailyColor.dateString (Must return it as a date converted to a string)
    init(colorSelected:Bool, thisColorSelected:String, dateOfEntry: Date){
        let df = DateFormatter()
        df.dateStyle = .short
        let dateString = df.string(from: Date())
        _daliy = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "dateString == %@", dateString))
        self._colorSelected = State(initialValue: colorSelected)
        self._thisColorSelected = State(initialValue: thisColorSelected)
        self._dateOfEntry = State(initialValue: dateOfEntry)
    }
    
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
                print(daliy)
                let newColorData = DailyColor(context: dataController.container.viewContext)
                df.dateStyle = DateFormatter.Style.short
                newColorData.dateString = (df.string(from: dateOfEntry))
                newColorData.color = thisColorSelected
                print(newColorData)
                //save the date to colorData
                try? dataController.save()
            }
            .frame(minWidth: 0, maxWidth: 100)
            .padding()
            .background(Color("SystemColor"))
            .clipShape(Capsule())
            .foregroundColor(.white)
            Spacer()
            
        }
    }
}

struct ColorMap_Previews: PreviewProvider {
    static var previews: some View {
        ColorMap(colorSelected: false, thisColorSelected: "SystemColor", dateOfEntry: Date())
    }
}
