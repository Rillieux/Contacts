//
//  ContactForm.swift
//  Contacts
//
//  Created by Dave Kondris on 15/07/21.
//

import SwiftUI

struct ContactForm: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text("Contact form")
    }
}

struct ContactForm_Previews: PreviewProvider {
    static var previews: some View {
        ContactForm()
    }
}
