//
//  Persistence.swift
//  CoreDataAndCloudKitDemo
//
//  Created by Vitor Gledison Oliveira de Souza on 02/12/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    private let container: NSPersistentContainer
    var coreDataContext: NSManagedObjectContext { container.viewContext }
    
    private init() {
        container = NSPersistentCloudKitContainer(name: "CoreDataAndCloudKitDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
