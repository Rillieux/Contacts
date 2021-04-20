//
//  ContactList.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI
import os

fileprivate let logger = Logger(subsystem: "com.gymsymbol.Contacts", category: "ContactList")

struct ContactList: View {
    
    @StateObject var viewModel: ContactList.ViewModel
    
    init(viewModel: ViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
                            logger.log("Add contact in view")
                            viewModel.addContact(name: "New Contact")
//                            viewModel.refreshContacts()
                        },
                        label: { Image(systemName: "plus.circle").font(.system(size: 20)) }
                    )
                }
            }
        }
    }
    
    func printName(contact: Contact) {
        print(contact.firstName)
    }
}



struct ContactList_Previews: PreviewProvider {
    
    //Doesn't really work at all....
    
    static var dummyContact: Contact {
        let contact = Contact(context: PersistenceController.preview.container.viewContext)
        contact.firstName = "Dummy"
        return contact
    }
    
    static var previews: some View {
        let viewModel = ContactList.ViewModel()
        viewModel.contacts = [dummyContact]
        
        return ContactList(viewModel: viewModel)
    }
}
