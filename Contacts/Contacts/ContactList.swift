//
//  ContactList.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI

struct ContactList: View {
    
    @StateObject private var viewModel: ContactList.ViewModel
    
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
                            Text("\(contact.displayName())")
                    }
                }
                .onDelete(perform: { indexSet in
                    viewModel.deleteContacts(at: indexSet)
                    viewModel.refreshContacts()
                })
            }
            .onAppear(perform: viewModel.refreshContacts)
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: { EditButton() })
                ToolbarItem(placement: .navigationBarTrailing) {
                    addContactButton
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
            label: {
                Image(systemName: "plus.circle.fill").font(.system(size: 20))
            })
            .sheet(isPresented: $showingNewContactSheet, onDismiss: { viewModel.refreshContacts() }, content: { self.newContactSheet })
    }
    
    // The contact creation sheet.
    private var newContactSheet: some View {
        ContactForm()
    }
}

struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: ContactList.ViewModel = .init(dataService: MockContactDataService())
        return ContactList(viewModel: viewModel)
    }
}
