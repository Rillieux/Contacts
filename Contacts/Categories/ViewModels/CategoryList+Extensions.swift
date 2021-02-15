//
//  CategoryList+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import Foundation
import CoreData

extension CategoryList {
    class ViewModel: ObservableObject {
        
        @Published var categories = [Category]()
        
        let context = PersistenceController.shared.container.viewContext
        
        func updateCategories() {
            print("UPDATING CATEGORIES")
            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
            let sort = NSSortDescriptor(key: "sortOrder", ascending: true)
            
            fetchRequest.sortDescriptors = [sort]
            do {
                categories = try context.fetch(fetchRequest) as! Array
            }
            catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    
        func deleteCategories(offsets: IndexSet) {
            print("DELETING CATEGORIES")
            offsets.map { categories[$0] }.forEach(context.delete)
            do {
                try context.save()
                updateCategories()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        ///The following function saves the order of the categories based on the user's moving them in edit mode on the list.
        ///Sourced StackOverflow in an answer by Bill Nattaner: https://stackoverflow.com/questions/59742218/swiftui-reorder-coredata-objects-in-list
        func moveCategories( from source: IndexSet, to destination: Int) {
            print("MOVING CATEGORIES")
            // Make an array of items from fetched results
            var revisedCategories: [Category] = categories.map{ $0 }
            
            // change the order of the items in the array
            revisedCategories.move(fromOffsets: source, toOffset: destination )
            
            // update the sortOrder attribute in revisedItems to
            // persist the new order. This is done in reverse order
            // to minimize changes to the indices.
            for reverseIndex in stride( from: revisedCategories.count - 1,
                                        through: 0,
                                        by: -1 )
            {
                revisedCategories[ reverseIndex ].sortOrder =
                    Int16( reverseIndex )
            }
            do {
                try context.save()
                updateCategories()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        func addCategory(name: String) {
            print("ADDING CATEGORY")
            if name != "" {
                do {
                    let newCategory = Category(context: context)
                    newCategory.name = name
                    newCategory.colorAsHex = "2a2a2a"
                    newCategory.sortOrder = Int16(categories.count)
                    try context.save()
                    updateCategories()
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
