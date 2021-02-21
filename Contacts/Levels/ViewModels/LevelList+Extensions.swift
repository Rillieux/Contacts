//
//  LevelList+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import Foundation
import CoreData

extension LevelList {
    class ViewModel: ObservableObject {
        
        @Published var levels = [Level]()
        
        let context = PersistenceController.shared.container.viewContext
        
        func updateLevels() {
            print("UPDATING LEVELS")
            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Level")
            let sort = NSSortDescriptor(key: "sortOrder", ascending: true)
            
            fetchRequest.sortDescriptors = [sort]
            do {
                levels = try context.fetch(fetchRequest) as! Array
            }
            catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    
        func deleteLevels(offsets: IndexSet) {
            print("DELETING LEVELS")
            offsets.map { levels[$0] }.forEach(context.delete)
            do {
                try context.save()
                updateLevels()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        ///The following function saves the order of the levels based on the user's moving them in edit mode on the list.
        ///Sourced StackOverflow in an answer by Bill Nattaner: https://stackoverflow.com/questions/59742218/swiftui-reorder-coredata-objects-in-list
        func moveLevels( from source: IndexSet, to destination: Int) {
            print("MOVING LEVELS")
            // Make an array of items from fetched results
            var revisedLevels: [Level] = levels.map{ $0 }
            
            // change the order of the items in the array
            revisedLevels.move(fromOffsets: source, toOffset: destination )
            
            // update the sortOrder attribute in revisedItems to
            // persist the new order. This is done in reverse order
            // to minimize changes to the indices.
            for reverseIndex in stride( from: revisedLevels.count - 1,
                                        through: 0,
                                        by: -1 )
            {
                revisedLevels[ reverseIndex ].sortOrder =
                    Int16( reverseIndex )
            }
            do {
                try context.save()
                updateLevels()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        func addLevel(name: String) {
            print("ADDING LEVEL")
            if name != "" {
                do {
                    let newLevel = Level(context: context)
                    newLevel.name = name
                    newLevel.colorAsHex = "2a2a2a"
                    newLevel.sortOrder = Int16(levels.count)
                    try context.save()
                    updateLevels()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    
                }
            } else {
                return
            }
        }
    }
}
