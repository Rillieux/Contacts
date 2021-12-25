//
//  ContactForm+Extension.swift
//  ContactForm+Extension
//
//  Created by Dave Kondris on 16/07/21.
//

import SwiftUI
import PhotoSelectAndCrop

extension ContactForm {
    
    class ViewModel: ObservableObject {
        
        let dataService: ContactDataServiceProtocol
        
        init(dataService: ContactDataServiceProtocol = ContactDataService()) {
            self.dataService = dataService
        }
        
        func addContact(givenName: String, middleName: String, familyName: String, nickname: String, image: ImageAttributes?) {
            dataService.addContact(
                givenName: givenName.trimmingCharacters(in: .whitespacesAndNewlines),
                middleName: middleName.trimmingCharacters(in: .whitespacesAndNewlines),
                familyName: familyName.trimmingCharacters(in: .whitespacesAndNewlines),
                nickName: nickname.trimmingCharacters(in: .whitespacesAndNewlines),
                image: image
            )
        }
    }
}
