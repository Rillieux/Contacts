//
//  LevelForm+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import Foundation
import CoreData
import UIKit

extension LevelForm {
    class ViewModel: ObservableObject {
        
        let context = PersistenceController.shared.container.viewContext
        
        @Published var name: String
        @Published var color: UIColor
        @Published var contacts = [Contact]()
        
        private var level: Level
        
        init(level: Level) {
            self.level = level
            self.name = level.name
            self.color = level.color
            
        }
        
        func updateContacts() {
            print("UPDATING CONTACTS IN LEVEL FORM VIEW")
            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
            let sort = NSSortDescriptor(key: "lastName_", ascending: true)
            var predicate: NSPredicate?
            predicate = NSPredicate(format: "level = %@", level)
            fetchRequest.sortDescriptors = [sort]
            fetchRequest.predicate = predicate
            do {
                contacts = try context.fetch(fetchRequest) as! Array
            }
            catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        func refreshWithNoChanges(){
            print("REFRESHING VIEW")
            context.refresh(level, mergeChanges: false)
        }
        
        func saveLevel(){
            print("SAVING LEVEL")
            do {
                level.name = name
                level.color = color
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                
            }
        }
    }
    
    enum ValidationError: LocalizedError {
        case missingName
        var errorDescription: String? {
            switch self {
                case .missingName:
                    return "Please enter a name for the level."
            }
        }
    }
}


