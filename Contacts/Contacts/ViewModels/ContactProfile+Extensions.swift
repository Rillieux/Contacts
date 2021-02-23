//
//  ContactProfile+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 16/02/21.
//

import Foundation
import CoreData
import UIKit

extension ContactProfile {
    class ViewModel: ObservableObject {
        
        let context = PersistenceController.shared.container.viewContext
        
        @Published var firstName: String
        @Published var lastName: String
        @Published var birthdate: Date?

        @Published var originalImage: UIImage?
        @Published var zoom: CGFloat?
        @Published var position: CGSize?
        @Published var inputImage: UIImage?
        
        var contact: Contact
        var age: String?
        
        init(contact: Contact) {
            self.contact = contact
            self.firstName = contact.firstName
            self.lastName = contact.lastName
            self.birthdate = contact.birthdate
            self.age = contact.age
        }
        
        func refreshWithNoChanges(){
            print("REFRESHING CONTACT PROFILE VIEW")
            firstName = contact.firstName
            lastName = contact.lastName
            birthdate = contact.birthdate
            context.refresh(contact, mergeChanges: false)
            
        }
        
        //        func saveContactImage() {
        //
        //            guard let inputImage = inputImage else { return }
        //
        //            if contact.picture != nil {
        //                contact.picture!.image = inputImage
        //                contact.picture!.originalImage = originalImage!
        //                contact.picture!.scale = zoom!
        //                contact.picture!.xWidth = Double(position!.width)
        //                contact.picture!.yHeight = Double(position!.height)
        //
        //            } else {
        //
        //                let newContactImage = ContactImage(context: contact.managedObjectContext!)
        //
        //                if originalImage != nil && zoom != nil && position != nil {
        //                    newContactImage.image = inputImage
        //                    newContactImage.originalImage = originalImage!
        //                    newContactImage.scale = zoom!
        //                    newContactImage.xWidth = Double(position!.width)
        //                    newContactImage.yHeight = Double(position!.height)
        //                    newContactImage.contact = contact
        //                }
        //            }
        //
        //            do {
        //                try context.save()
        //                context.refresh(contact, mergeChanges: true)
        //            } catch {
        //                errorAlertTitle = (error as? LocalizedError)?.errorDescription ?? "An error occurred"
        //                errorAlertIsPresented = true
        //            }
        //        }
        
        func saveContact() throws {
            print("SAVING CONTACT")
            if self.firstName == "" {
                throw ValidationError.missingFirstName
            }
            if self.lastName == "" {
                throw ValidationError.missingLastName
            }
            do {
                contact.firstName = firstName
                contact.lastName = lastName
                contact.birthdate = birthdate
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                
            }
        }
        
        func resetContact(){
            
        }
    }
    
    enum ValidationError: LocalizedError {
        case missingFirstName
        case missingLastName
        var errorDescription: String? {
            switch self {
                case .missingFirstName:
                    return "Please enter a first name for this contact."
                case .missingLastName:
                    return "Please enter a last name for this contact."
            }
        }
    }
}


