//
//  DataController.swift
//  WriteItOut
//
//  Created by Katy Dunn on 9/1/22.
//
import CoreData
import Foundation


class DataController: ObservableObject{
    static let shared = DataController()
    
    let container:NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DataModel")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    

    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Whoops")
            }
        }
    }
}


//// A singleton for our entire app to use
//    static let shared = PersistenceController()
//
//    // Storage for Core Data
//    let container: NSPersistentContainer
//
//    // A test configuration for SwiftUI previews
//    static var preview: PersistenceController = {
//        let controller = PersistenceController(inMemory: true)
//
//        // Create 10 example programming languages.
//        for _ in 0..<10 {
//            let language = ProgrammingLanguage(context: controller.container.viewContext)
//            language.name = "Example Language 1"
//            language.creator = "A. Programmer"
//        }
//
//        return controller
//    }()
//
//    // An initializer to load Core Data, optionally able
//    // to use an in-memory store.
//    init(inMemory: Bool = false) {
//        // If you didn't name your model Main you'll need
//        // to change this name below.
//        container = NSPersistentContainer(name: "Main")
//
//        if inMemory {
//            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
//        }
//
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Error: \(error.localizedDescription)")
//            }
//        }
//    }
//}


//let request: NSFetchRequest<DailyColor> = DailyColor.fetchRequest()
//request.fetchLimit = 10


//static var preview: DataController = {
//        let controller = DataController(inMemory: true)
//
//        // Create 10 example programming languages.
//        for _ in 0..<10 {
//            let fakeColor = DailyColor(context: controller.container.viewContext)
//            fakeColor.color = feelingArray.randomElement()
//            fakeColor.dateString = "9/6/22"
//        }
//
//        return controller
//    }()
