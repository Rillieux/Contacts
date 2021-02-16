//
//  CategoryForm+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import Foundation
import CoreData
import UIKit

    extension CategoryForm {
        class ViewModel: ObservableObject {
            
            let context = PersistenceController.shared.container.viewContext
            
            @Published var name: String
            @Published var color: UIColor
            @Published var contacts = [Contact]()
            
            private var category: Category
            
            init(category: Category) {
                self.category = category
                self.name = category.name
                self.color = category.color
                
            }
            
            func updateContacts() {
                print("UPDATING CONTACTS IN CATEGORY FORM VIEW")
                let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
                let sort = NSSortDescriptor(key: "lastName_", ascending: true)
                var predicate: NSPredicate?
                predicate = NSPredicate(format: "category = %@", category)
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
                context.refresh(category, mergeChanges: false)
            }
            
            func saveCategory(){
                print("SAVING CATEGORY")
                do {
                    category.name = name
                    category.color = color
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    
                }
            }
        }
    }


