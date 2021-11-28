//
//  ContactForm.swift
//  Contacts
//
//  Created by Dave Kondris on 15/07/21.
//

import SwiftUI
import PhotoSelectAndCrop

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
    @State private var image: ImageAttributes = contactImagePlaceholder
    
    @State private var isEditMode = true
    var body: some View {
        NavigationView {
            VStack {
                ImagePane(image: image, isEditMode: $isEditMode)
                    .frame(width: 160, height: 160)
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
                            nickname: nickname,
                            image: image
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
