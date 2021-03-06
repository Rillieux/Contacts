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

        func loadProfileFromContact(_ contact: Contact) {
            firstName = contact.firstName
        }
        
        func updateContact(_ contact: Contact) {
            contact.firstName = firstName
            ContactDataService.shared.updateContact(contact)
            logger.log("Updating contact")
        }
        
        func deleteContact(_ contact: Contact) {
            ContactDataService.shared.deleteContact(contact)
        }
    }
}
