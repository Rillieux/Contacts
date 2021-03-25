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
        
        let dataService: ContactDataService
        
        init(dataService: ContactDataService = ContactDataService()) {
            self.dataService = dataService
        }
        
        func getContacts() {
            contacts = ContactDataService.shared.contacts
        }
        
        func addContact(name: String) {
            dataService.addContact(name: name)
        }
        
        func deleteContacts(offsets: IndexSet) {
            let context = PersistenceController.shared.container.viewContext
            print("DELETING USERS IN VIEWMODEL")
            offsets.map { contacts[$0] }.forEach(context.delete)
            do {
                try context.save()
                contacts = ContactDataService.shared.contacts
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
