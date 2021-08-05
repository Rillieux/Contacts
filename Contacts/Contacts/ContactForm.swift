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
    
    @State private var givenName: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "camera.aperture")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                TextField("Given name", text: $givenName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                
            }
            .padding()
            .navigationTitle("New Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading)
                    { Text("Cancel") }
                ToolbarItem (placement: .navigationBarTrailing)
                    { Text("Save") }
                
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
