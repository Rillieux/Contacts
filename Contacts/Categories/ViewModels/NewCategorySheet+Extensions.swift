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
        
        ///We create the name and color here, but we get the Int for
        ///the sortOrder from the `private var newCategorySheet`
        ///in the CategoryList view.
        
        @Published var name = ""
        @Published var color: UIColor = .gray
        
        let context = PersistenceController.shared.container.viewContext

        func addCategory(sortOrder: Int) throws {
            print("ADDING NEW CATEGORY")
            if self.name == "" {
                throw ValidationError.missingName
            }
            
            do {
                let newCategory = Category(context: context)
                newCategory.name = name
                newCategory.color = color
                
                ///Don't forget that the entity is using a 16Int,
                ///so we need to ensure the right kind of Int here:
                newCategory.sortOrder = Int16(sortOrder)
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
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
}
