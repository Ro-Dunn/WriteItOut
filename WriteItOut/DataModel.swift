//
//  DataModel.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/31/22.
//
import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "WriteItOut")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
