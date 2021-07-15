//
//  ContactList.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI

struct ContactList: View {
    
    @StateObject var viewModel: ContactList.ViewModel
    
    init(viewModel: ViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @State var showingNewContactSheet = false
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(viewModel.contacts) { contact in
                    NavigationLink(
                        destination: ContactProfile(contact: contact)) {
                        Text("\(contact.firstName)")
                            .onAppear(perform: {printName(contact: contact)})
                    }
                }
//                .onDelete(perform: { indexSet in
//                    viewModel.deleteContacts(offsets: indexSet)
//                })
            }
//            .onAppear(perform: viewModel.refreshContacts)
            .navigationTitle("Contacts: \(viewModel.contacts.count)")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: { EditButton() })
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            //show new contact form
//                            viewModel.refreshContacts()
                        },
                        label: { Image(systemName: "plus.circle").font(.system(size: 20)) }
                    )
                }
            }
        }
    }
    
    // The button that presents the contact creation sheet.
    private var addContactButton: some View {
        Button(
            action: {
                self.showingNewContactSheet = true
            },
            label: { Image(systemName: "plus").imageScale(.large) })
            .sheet(
                isPresented: $showingNewContactSheet,
                content: { self.newContactSheet })
    }
    
    // The contact creation sheet.
    private var newContactSheet: some View {
        ContactForm(
            dismissAction: {
                self.showingNewContactSheet = false
            })
    }
    
    func printName(contact: Contact) {
        print(contact.firstName)
    }
}



struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: ContactList.ViewModel = .init(dataService: MockContactDataService())
        return ContactList(viewModel: viewModel)
    }
}
