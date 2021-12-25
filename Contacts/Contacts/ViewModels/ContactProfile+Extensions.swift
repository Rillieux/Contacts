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
        @Published var image: ImageAttributes = ImageAttributes(withSFSymbol: imagePlaceholder)
        
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
            
            //We haven't saved an image yet for this contact, but
            //we have selected one in the picker, so now we want to save it.
            if contact.profileImage == nil && image.originalImage != nil {
                dataService.createNewProfileImage(from: image, for: contact)
            } else {
                contact.profileImage?.originalImage = image.originalImage
                contact.profileImage?.image = image.croppedImage
                contact.profileImage?.scale = image.scale
                contact.profileImage?.xWidth = image.xWidth
                contact.profileImage?.yHeight = image.yHeight
            }
            dataService.updateContact(contact)
            findPath()
        }
        
        func loadProfileFromContact(_ contact: Contact) {
            self.givenName = contact.givenName
            self.middleName = contact.middleName
            self.familyName = contact.familyName
            self.nickname = contact.nickname
            self.birthdate = contact.birthdate ?? Date()
            guard let image = contact.profileImage?.attributes() else {
                return
            }
            self.image = image
        }
    }
}
