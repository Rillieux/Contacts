//
//  ContactForm.swift
//  Contacts
//
//  Created by Dave Kondris on 15/07/21.
//

import SwiftUI

struct ContactForm: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: ContactForm.ViewModel
    
    init(viewModel: ViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @State private var givenName = ""
    @State private var middleName = ""
    @State private var familyName = ""
    @State private var nickname = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "camera.aperture")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                Group {
                    TextField("Given name", text: $givenName)
                    TextField("Middle name", text: $middleName)
                    TextField("Family name", text: $familyName)
                    TextField("Nickname", text: $nickname)

                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                
            }
            .padding()
            .navigationTitle("New Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }
                    ) {
                        Text("Cancel")
                    }
                }
                ToolbarItem (placement: .navigationBarTrailing)
                {
                    Button(action:
                            {
                        viewModel.addContact(
                            givenName: givenName,
                            middleName: middleName,
                            familyName: familyName,
                            nickname: nickname
                        )
                        presentationMode.wrappedValue.dismiss()
                    }
                    ) {
                        Text("Add")
                    }
                }
            }
        }
    }
}

struct ContactForm_Previews: PreviewProvider {
    static var previews: some View {
        //        let viewModel: ContactForm.ViewModel = .init(dataService: MockContactDataService())
        //        let contacts = viewModel.dataService.getContacts()
        //        let contact = contacts[0]
        ContactForm()
    }
}
