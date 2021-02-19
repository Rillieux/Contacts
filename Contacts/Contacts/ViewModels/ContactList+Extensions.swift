//
//  ContactList+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 16/02/21.
//

import Foundation
import CoreData

extension ContactList {
    class ViewModel: ObservableObject {
        
        @Published var contacts = [Contact]()
        
        let context = PersistenceController.shared.container.viewContext
        
        func updateContacts() {
            print("UPDATING CONTACTS")
            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
            let sort1 = NSSortDescriptor(key: "lastName_", ascending: true)
            let sort2 = NSSortDescriptor(key: "firstName_", ascending: true)

            fetchRequest.sortDescriptors = [sort1, sort2]
            do {
                contacts = try context.fetch(fetchRequest) as! Array
            }
            catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        func deleteContacts(offsets: IndexSet) {
            print("DELETING CONTACTS")
            offsets.map { contacts[$0] }.forEach(context.delete)
            do {
                try context.save()
                updateContacts()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        func addContact(firstName: String, lastName: String) {
            print("ADDING CONTACT")
            if firstName != "" && lastName != "" {
                do {
                    let newContact = Contact(context: context)
                    newContact.firstName = firstName
                    newContact.lastName = lastName
                    try context.save()
                    updateContacts()
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
