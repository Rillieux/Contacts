//
//  ContactProfile.swift
//  Contacts
//
//  Created by Dave Kondris on 25/03/21.
//

import SwiftUI

struct ContactProfile: View {
    
    @StateObject var viewModel: ContactProfile.ViewModel
    
    var contact: Contact
    
    init(viewModel: ViewModel = .init(), contact: Contact) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.contact = contact
    }
    
    @State private var name: String = ""

    var body: some View {
        VStack {
            TextField("NAME", text: $viewModel.firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onAppear(perform: {
                    viewModel.loadProfileFromContact(contact)
                })
            HStack (spacing: 24) {
                Button(action: {
                    viewModel.updateContact(contact)
                }, label: {
                    Text("Save")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 110, height: 44, alignment: .center)
                        .padding(5)
                        .background(Color.green)
                        .cornerRadius(8)
                    
                })
                Button(action: {
                    viewModel.deleteContact(contact)
                }, label: {
                    Text("Delete")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 110, height: 44, alignment: .center)
                        .padding(5)
                        .background(Color.red)
                        .cornerRadius(8)
                    
                })

            }
            .padding(.horizontal)

        }
    }
}

//struct ContactProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactProfile(, contact: <#Contact#>)
//    }
//}
