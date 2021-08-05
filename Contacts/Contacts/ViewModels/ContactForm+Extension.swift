//
//  ContactForm+Extension.swift
//  ContactForm+Extension
//
//  Created by Dave Kondris on 16/07/21.
//

import SwiftUI

extension ContactForm {
    
    class ViewModel: ObservableObject {
        
        let dataService: ContactDataServiceProtocol
        
        @Published var givenName: String = ""
        
        init(dataService: ContactDataServiceProtocol = ContactDataService()) {
            self.dataService = dataService
        }
        
        func addContact() {
            dataService.addContact(name: givenName)
        }
    }
}
