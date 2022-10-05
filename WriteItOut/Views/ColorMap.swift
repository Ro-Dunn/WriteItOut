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
    @State private var didEntryToday = UserDefaults.standard.bool(forKey: "didEntryToday")//bool
    @State private var lastEntry = UserDefaults.standard.string(forKey: "entryToday")//date of last entry
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "dateString", ascending: false)]) var daliy: FetchedResults<DailyColor>
    
    @State public var colorSelected:Bool
    @State public var thisColorSelected:String //dailyColor.color
    @State public var dateOfEntry:Date = Date()
    @State public var df = DateFormatter() //going to be dailyColor.dateString (Must return it as a date converted to a string)
    @State var noneToday:Bool
    
    init(colorSelected:Bool, thisColorSelected:String, dateOfEntry: Date, noneToday:Bool){
        let df = DateFormatter()
        df.dateStyle = .short
        _daliy = FetchRequest(sortDescriptors: [NSSortDescriptor(key: "dateString", ascending: true)])
        self._colorSelected = State(initialValue: colorSelected)
        self._thisColorSelected = State(initialValue: thisColorSelected)
        self._dateOfEntry = State(initialValue: dateOfEntry)
        self._noneToday = State(initialValue: noneToday)
    }
    
    var body: some View {
        if noneToday == false {
            VStack{
                Circle()
                    .fill(colorSelected == true ? Color("\(thisColorSelected)") : Color("SystemColor"))
                    .frame(width: 100, height: 100)
                Divider()
                
                VStack {
                    Divider()
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            ForEach (feelingArray.sorted(by: >), id: \.key) { key, value in
                                CircleView(label: key, color: value)
                                    .onTapGesture {
                                        colorSelected = true
                                        thisColorSelected = key
                                    }
                            }
                        }.padding()
                        
                    }.frame(height: 100)
                }
                
                Button("Save") {
                    let newColorData = DailyColor(context: dataController.container.viewContext)
                    df.dateStyle = DateFormatter.Style.short
                    newColorData.dateString = (df.string(from: dateOfEntry))
                    newColorData.color = thisColorSelected
                    noneToday = !didEntryToday
                }
                .frame(minWidth: 0, maxWidth: 100)
                .padding()
                .background(Color("SystemColor"))
                .clipShape(Capsule())
                .foregroundColor(.white)
                Spacer()
            }
            
        } else {
            
            Button("Make Entry"){
                noneToday = didEntryToday
            }
            
            Form{
                ForEach(daliy) { daily in
                    HStack {
                        Text(daily.dateString ?? "No entry found")
                        Circle()
                            .fill(Color(daily.color ?? "SystemColor"))
                        Spacer()
                    }
                }
                .onDelete(perform: removeColors)
            }
        }
    }
    func removeColors(at offsets: IndexSet) {
        for index in offsets {
            let daily = daliy[index]
            moc.delete(daily)
            try? dataController.save()
        }
    }
}



struct ColorMap_Previews: PreviewProvider {
    static var previews: some View {
        ColorMap(colorSelected: false, thisColorSelected: "SystemColor", dateOfEntry: Date(), noneToday: false)
    }
}

