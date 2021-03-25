//
//  AppDataService.swift
//  Blocks
//
//  Created by Dave Kondris on 24/03/21.
//

fileprivate let logger = Logger(subsystem: "com.gymsymbol.Contacts", category: "ContactDataService")

import Foundation
import CoreData
import os

    class ContactDataService: NSObject, ObservableObject {
        var contacts = [Contact]()
        private let contactFetchController: NSFetchedResultsController<Contact>
        static let shared: ContactDataService = ContactDataService()
        
        public override init() {
            let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "firstName_", ascending: true)]
            contactFetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistenceController.shared.container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            
            super.init()
            
            contactFetchController.delegate = self
            
            do {
                try contactFetchController.performFetch()
                contacts = contactFetchController.fetchedObjects ?? []
            } catch {
                NSLog("Error: could not fetch objects <Contact>")
            }
        }
        
        func addContact(name: String) {
            logger.log("Adding contact: \(name)")
            let newContact = Contact(context: PersistenceController.shared.container.viewContext)
            newContact.setValue(name, forKey: "firstName_")
            saveContext()
        }
        
        func updateContact(_ contact: Contact) {
            logger.log("Updating contact: \(contact.firstName)")
            saveContext()
        }
        
        func deleteContact(_ contact: Contact) {
            PersistenceController.shared.container.viewContext.delete(contact)
            logger.log("Deleting contact: \(contact.firstName)")
            saveContext()
        }
        
        private func saveContext() {
            do {
                logger.log("Saving context")
                try PersistenceController.shared.container.viewContext.save()
                logger.log("Successfully saved context")
            } catch {
                logger.error("ERROR: \(error as NSObject)")
            }
        }
    }

    extension ContactDataService: NSFetchedResultsControllerDelegate {
        public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            guard let contacts = controller.fetchedObjects as? [Contact] else { return }
            logger.log("Context has changed, reloading contacts")
            self.contacts = contacts
        }
    }
