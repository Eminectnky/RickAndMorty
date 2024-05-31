//
//  PersistenceController.swift
//  RickAndMorty
//
//  Created by Emine CETINKAYA on 31.05.2024.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
        
        let container: NSPersistentContainer
        
        init() {
            container = NSPersistentContainer(name: "RickAndMortyModel")
            container.loadPersistentStores { (description, error) in
                if let error = error {
                    fatalError("Failed to load Core Data stack: \(error.localizedDescription)")
                }
            }
        }
        
        func saveContext() {
            let context = container.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
}
