//
//  ContactProfile+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 25/03/21.
//

import Foundation
import os

fileprivate let logger = Logger(subsystem: "com.gymsymbol.Contacts", category: "ContactProfile.ViewModel")


extension ContactProfile {
    
    class ViewModel: ObservableObject {
        
        @Published var firstName: String = ""
        
        let dataService: ContactDataService
        
        init(dataService: ContactDataService = ContactDataService()) {
            self.dataService = dataService
        }
        
        func loadProfileFromContact(_ contact: Contact) {
            firstName = contact.firstName
        }
        
        func updateContact(_ contact: Contact) {
            contact.firstName = firstName
            dataService.updateContact(contact)
            logger.log("Updating contact")
        }
        
        func deleteContact(_ contact: Contact) {
            dataService.deleteContact(contact)
        }
    }
}
