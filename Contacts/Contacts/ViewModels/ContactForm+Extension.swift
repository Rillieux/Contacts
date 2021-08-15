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
        
        init(dataService: ContactDataServiceProtocol = ContactDataService()) {
            self.dataService = dataService
        }
        
        func addContact(givenName: String, middleName: String, familyName: String, nickname: String) {
            dataService.addContact(
                givenName: givenName,
                middleName: middleName,
                familyName: familyName,
                nickName: nickname
            )
        }
    }
}
