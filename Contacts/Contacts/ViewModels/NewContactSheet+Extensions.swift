//
//  NewContactSheet+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 16/02/21.
//

import Foundation
import CoreData
import UIKit

extension NewContactSheet {
    class ViewModel: ObservableObject {
        
        ///We create the name and color here, but we get the Int for
        ///the sortOrder from the `private var newCategorySheet`
        ///in the CategoryList view.
        


        @Published var firstName = ""
        @Published var lastName = ""
//        @Published var birthdate:Date = defaultDOB

        let context = PersistenceController.shared.container.viewContext
        
        func addContact() throws {
            print("ADDING NEW CONTACT")
            if self.firstName == "" {
                throw ValidationError.missingFirstName
            }
            if self.lastName == "" {
                throw ValidationError.missingLastName
            }

            do {
                let newContact = Contact(context: context)
                newContact.firstName = firstName
                newContact.lastName = lastName
                
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        enum ValidationError: LocalizedError {
            case missingFirstName
            case missingLastName
            var errorDescription: String? {
                switch self {
                    case .missingFirstName:
                        return "Please enter a first name for the contact."
                    case .missingLastName:
                        return "Please enter a last name for the contact."
                }
            }
        }
    }
}
