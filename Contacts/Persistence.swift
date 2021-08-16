//
//  Persistence.swift
//  Contacts
//
//  Created by Dave Kondris on 14/07/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<6 {
            let givenNames = ["安納", "Abby", "Clarisse", "Evelynne"]
            let familyNames = ["王", "Clark", "Forester", "Hamilton"]
            let newContact = Contact(context: viewContext)
            newContact.givenName_ = givenNames.randomElement()
            newContact.familyName_ = familyNames.randomElement()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer
    
    var viewcontext: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Contacts")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func save() {
        do {
            try viewcontext.save()
        } catch {
            viewcontext.rollback()
            print(error.localizedDescription)
        }
    }
}
