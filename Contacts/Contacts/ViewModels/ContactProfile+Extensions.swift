//
//  ContactProfile+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 25/03/21.
//

import SwiftUI
import PhotoSelectAndCrop

extension ContactProfile {
    
    class ViewModel: ObservableObject {
        
        let dataService: ContactDataServiceProtocol
        
        @Published var givenName: String = ""
        @Published var middleName: String = ""
        @Published var familyName: String = ""
        @Published var nickname: String = ""
        @Published var birthdate: Date = Date()
        @Published var image: ImageAttributes = ImageAttributes(withSFSymbol: "camera.aperture")
        
        init(dataService: ContactDataServiceProtocol = ContactDataService()) {
            self.dataService = dataService
            self.birthdate = Calendar.current.date(byAdding: DateComponents(year: -14), to: Date()) ?? Date()
        }
        
        func updateContact(_ contact: Contact){
            contact.givenName = givenName
            contact.middleName = middleName
            contact.familyName = familyName
            contact.nickname = nickname
            contact.birthdate = birthdate
            dataService.updateContact(contact)
            findPath()
        }
        
        func loadProfileFromContact(_ contact: Contact) {
            self.givenName = contact.givenName
            self.familyName = contact.familyName
            self.birthdate = contact.birthdate ?? Date()
        }
    }
}
