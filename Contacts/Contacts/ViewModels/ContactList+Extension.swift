//
//  ContactList+Extension.swift
//  Contacts
//
//  Created by Dave Kondris on 14/07/21.
//

import SwiftUI
import CoreData

extension ContactList {
    
    class ViewModel: ObservableObject {
        
        let dataService: ContactDataServiceProtocol
        
        @Published var contacts: [Contact] = []
        
        init(dataService: ContactDataServiceProtocol = ContactDataService()) {
            self.dataService = dataService
        }
        
        func getContacts() {
            self.contacts = dataService.getContacts()
        }
        
        func deleteContacts(at offsets: IndexSet) {
            offsets.forEach { index in
                let contact = contacts[index]
                dataService.deleteContact(contact)
            }
        }
    }
}
