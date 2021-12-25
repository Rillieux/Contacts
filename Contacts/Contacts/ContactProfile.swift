//
//  ContactProfile.swift
//  Contacts
//
//  Created by Dave Kondris on 25/03/21.
//

import SwiftUI
import PhotoSelectAndCrop

struct ContactProfile: View {

    @StateObject var viewModel: ContactProfile.ViewModel
    
    @State private var isEditMode: Bool = false
    
    var contact: Contact
    
    init(viewModel: ViewModel = .init(), contact: Contact) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.contact = contact
    }
    
    @State private var showAlert: Bool = false
    
    let profileLarge: CGFloat = 240
    let profileSmall: CGFloat = 160

    var body: some View {
        VStack {
            ImagePane(image: viewModel.image, isEditMode: $isEditMode, renderingMode: .hierarchical, colors: [.systemTeal])
                .frame(
                    width: isEditMode ? profileSmall : profileLarge,
                    height: isEditMode ? profileSmall : profileLarge)
                .onTapGesture(count: 2, perform: {
                    toggleIsEditMode()
                })
            if !isEditMode {
                VStack (spacing: 8) {
                    Text("\(contact.givenName) \(contact.familyName)")
                        .font(.largeTitle)
                        .lineLimit(1)
                        .minimumScaleFactor(0.667)
                    Text(contact.birthdate?.ageInYearsAndMonths ?? "Unknown age")
                    HStack {
                        Circle().fill(Color.systemPink)
                            .frame(width: 12, height: 12)
                        Text("Category").bold()
                    }
                }
                .padding(.top, -22)
            } else {
                Group {
                    TextField("Given Name", text: $viewModel.givenName)
                    TextField("Middle Name", text: $viewModel.middleName)
                    TextField("Family Name", text: $viewModel.familyName)
                    TextField("Nickame", text: $viewModel.nickname)
                    DatePicker(selection: $viewModel.birthdate, in: ...Date(), displayedComponents: .date) {
                        Text( contact.birthdate != nil ? "Change birthdate" : "Pick birthdate" )
                    }
                }
            }
            Spacer()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .padding(.top, -36)
        .onAppear(perform: {
            viewModel.loadProfileFromContact(contact)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if isEditMode {
                    Button("Cancel") {
                        toggleIsEditMode()
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditMode {
                    Button("Done") {
                        viewModel.updateContact(contact)
                        toggleIsEditMode()
                    }
                } else {
                    Button("Edit") {
                        toggleIsEditMode()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(isEditMode ? true : false)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func toggleIsEditMode() {
        withAnimation{
            isEditMode.toggle()
            viewModel.loadProfileFromContact(contact)
        }
    }
}

struct ContactProfile_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: ContactProfile.ViewModel = .init(dataService: MockContactDataService())
        let contacts = viewModel.dataService.getContacts()
        let contact = contacts[1]
        NavigationView {
            ContactProfile(contact: contact)
        }
    }
}
