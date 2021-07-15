//
//  ContactProfile+Extensions.swift
//  Contacts
//
//  Created by Dave Kondris on 25/03/21.
//

import SwiftUI

extension ContactProfile {
    
    class ViewModel: ObservableObject {
        
        let dataService: ContactDataServiceProtocol
        
        @Published var givenName: String = ""
        
        init(dataService: ContactDataServiceProtocol = ContactDataService()) {
            self.dataService = dataService
        }
    }
}
