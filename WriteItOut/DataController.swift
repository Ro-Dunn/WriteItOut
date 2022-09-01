//
//  DataController.swift
//  WriteItOut
//
//  Created by Katy Dunn on 9/1/22.
//
import CoreData
import Foundation


class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveTodaysColor() {
        
    }
    
    func todaysColor() -> DailyColor? {
        return nil
    }
    
}
