//
//  NewCategorySheet+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import Foundation
import CoreData
import UIKit

extension NewCategorySheet {
    class ViewModel: ObservableObject {
        
        var categories = [Category]()
        
        let context = PersistenceController.shared.container.viewContext
        
        func addCategory(name: String, color: UIColor, sortOrder: Int) {
            print("ADDING CATEGORY")
            if name != "" {
                do {
                    let newCategory = Category(context: context)
                    newCategory.name = name
                    newCategory.color = color
                    newCategory.sortOrder = Int16(sortOrder)
                    try context.save()
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

extension NewCategorySheet {
    enum ValidationError: LocalizedError {
        case missingName
        var errorDescription: String? {
            switch self {
                case .missingName:
                    return "Please enter a name for the category."
            }
        }
    }
}
