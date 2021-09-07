//
//  Contact+Manager.swift
//  Fish
//
//  Created by Dave Kondris on 22/04/21.
//

import CoreData
import Combine

    protocol ContactDataServiceProtocol {
        func getContacts() -> [Contact]
        func getContactById(id: NSManagedObjectID) -> Contact?
        func addContact(givenName: String, middleName: String, familyName: String, nickName: String)
        func updateContact(_ contact: Contact)
        func deleteContact(_ contact: Contact)
    }

    class ContactDataService: ContactDataServiceProtocol {
        
        var viewContext: NSManagedObjectContext = PersistenceController.shared.viewcontext
        
        func getContacts() -> [Contact] {
            let request: NSFetchRequest<Contact> = Contact.fetchRequest()
            let sort: NSSortDescriptor = NSSortDescriptor(keyPath: \Contact.givenName_, ascending: true)
            request.sortDescriptors = [sort]
            do {
                return try viewContext.fetch(request)
            } catch {
                return []
            }
        }
        
        func getContactById(id: NSManagedObjectID) -> Contact? {
            do {
                return try viewContext.existingObject(with: id) as? Contact
            } catch {
                return nil
            }
        }
        
        func addContact(givenName: String = "", middleName: String = "", familyName: String = "", nickName: String = "") {
            let newContact = Contact(context: viewContext)
            if !givenName.isEmpty {
                newContact.givenName = givenName
            }
            if !middleName.isEmpty {
                newContact.middleName = middleName
            }
            if !familyName.isEmpty {
                newContact.familyName = familyName
            }
            if !nickName.isEmpty {
                newContact.nickname = nickName
            }
            saveContext()
        }
        
        func updateContact(_ contact: Contact) {
            if contact.givenName.isEmpty {
                contact.givenName_ = nil
            }
            if contact.familyName.isEmpty {
                contact.familyName_ = nil
            }
            if dateIsLessThanOneYear(date: contact.birthdate ?? Date()) {
                contact.birthdate = nil
            }
            
            saveContext()
        }
    
    func deleteContact(_ contact: Contact) {
        viewContext.delete(contact)
        saveContext()
    }
    
    func saveContext() {
        PersistenceController.shared.save()
    }
}

class MockContactDataService: ContactDataService {
    override init() {
        super .init()
        self.viewContext = PersistenceController.preview.viewcontext
    }
}
