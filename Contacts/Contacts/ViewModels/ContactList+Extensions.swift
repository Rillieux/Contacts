//
//  ContactList+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 16/02/21.
//

import Combine
import CoreData
import os

fileprivate let logger = Logger(subsystem: "com.gymsymbol.Contacts", category: "ContactList ViewModel extension")

extension ContactList {
    class ViewModel: ObservableObject {
        
        @Published var contacts: [Contact] = []
        
//        let dataService: ContactDataService
        private var cancellable: AnyCancellable?
        
        init(contactPublisher: AnyPublisher<[Contact], Never> = ContactDataService.shared.contacts.eraseToAnyPublisher()) {
//            self.dataService = dataService
            cancellable = contactPublisher.sink { [unowned self] contacts in
                logger.log("Updating contacts")
                self.contacts = contacts
                
            }
            logger.log("Initializing ViewModel")
        }
        
//        func refreshContacts() {
//            contacts = dataService.contacts.value
//            logger.log("Getting contacts in viewModel")
//
//        }
//
        func addContact(name: String) {
            logger.log("Adding user in viewModel")
            ContactDataService.shared.addContact(name: name)
        }
//
//        func deleteContacts(offsets: IndexSet) {
//            let context = PersistenceController.shared.container.viewContext
//            logger.log("Deleting contacts in viewModel")
//            offsets.map { contacts[$0] }.forEach(context.delete)
//            do {
//                try context.save()
//                contacts = dataService.contacts.value
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
    }
}
