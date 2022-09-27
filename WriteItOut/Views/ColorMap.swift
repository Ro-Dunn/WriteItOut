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
    
    @FetchRequest var daliy: FetchedResults<DailyColor>
    
    @State public var colorSelected:Bool
    @State public var thisColorSelected:String //dailyColor.color
    @State public var dateOfEntry:Date = Date()
    @State public var df = DateFormatter() //going to be dailyColor.dateString (Must return it as a date converted to a string)
    @State var noneToday:Bool
    
    init(colorSelected:Bool, thisColorSelected:String, dateOfEntry: Date, noneToday:Bool){
        let df = DateFormatter()
        df.dateStyle = .short
        let dateString = df.string(from: Date())
        _daliy = FetchRequest(sortDescriptors: [])
        self._colorSelected = State(initialValue: colorSelected)
        self._thisColorSelected = State(initialValue: thisColorSelected)
        self._dateOfEntry = State(initialValue: dateOfEntry)
        self._noneToday = State(initialValue: noneToday)
    }
    
    var body: some View {
        if noneToday == true {
            VStack{
                Circle()
                    .fill(colorSelected == true ? Color("\(thisColorSelected)") : Color("SystemColor"))
                    .frame(width: 100, height: 100)
                Divider()
                
                Button("Show Me My Colors") {
                    noneToday.toggle()
                }.padding([.bottom, .top], 40)
                
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
                    let newColorData = DailyColor(context: dataController.container.viewContext)
                    df.dateStyle = DateFormatter.Style.short
                    newColorData.dateString = (df.string(from: dateOfEntry))
                    newColorData.color = thisColorSelected
                    noneToday = didEntryToday
                }
                .frame(minWidth: 0, maxWidth: 100)
                .padding()
                .background(Color("SystemColor"))
                .clipShape(Capsule())
                .foregroundColor(.white)
                Spacer()
            }
           
        } else {
            List {
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


//    func checkEntryAllowed(){
//        df.dateStyle = DateFormatter.Style.short
//        if (df.string(from: dateOfEntry)) == lastEntry {
//            try? dataController.save()
//            lastEntry = (df.string(from: dateOfEntry))
//            print("Last entry = yesterday")
//            didEntryToday = false
//        } else if daliy.last?.dateString == nil {
//            try? dataController.save()
//            lastEntry = df.string(from: dateOfEntry)
//            print("Last entry = nil")
//        } else {
//            noneToday = false
//            print("Last entry != nil or was done today")
//            //throw error saying HEY YOUVE ALREADY DONE ONE TODAY
//        }
