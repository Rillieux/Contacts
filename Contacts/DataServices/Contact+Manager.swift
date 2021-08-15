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
        newContact.givenName = givenName
        newContact.middleName = middleName
        newContact.familyName = familyName
        newContact.nickname = nickName
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
