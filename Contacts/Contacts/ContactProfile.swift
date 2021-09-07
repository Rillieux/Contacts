//
//  ContactProfile.swift
//  Contacts
//
//  Created by Dave Kondris on 25/03/21.
//

import SwiftUI

struct ContactProfile: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: ContactProfile.ViewModel
    
    var contact: Contact
    
    init(viewModel: ViewModel = .init(), contact: Contact) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.contact = contact
    }
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Text(contact.birthdate?.ageInYearsAndMonths ?? "dunno")
            TextField("Given Name", text: $viewModel.givenName)
            TextField("Middle Name", text: $viewModel.middleName)
            TextField("Family Name", text: $viewModel.familyName)
            TextField("Nickame", text: $viewModel.nickname)
            DatePicker(selection: $viewModel.birthdate, in: ...Date(), displayedComponents: .date) {
                Text( contact.birthdate != nil ? "Change birthdate" : "Pick birthdate" )
            }
            Spacer()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .onAppear(perform: {
            viewModel.loadProfileFromContact(contact)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    viewModel.updateContact(contact)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContactProfile_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: ContactProfile.ViewModel = .init(dataService: MockContactDataService())
        let contacts = viewModel.dataService.getContacts()
        let contact = contacts[0]
        ContactProfile(contact: contact)
    }
}
