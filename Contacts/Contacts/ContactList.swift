//
//  ContactList.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI

struct ContactList: View {
    @StateObject var viewModel: ContactList.ViewModel
    
    
    
    init(viewModel: ContactList.ViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @State var showingNewContactSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.contacts) { contact in
                        NavigationLink (
                            destination: ContactProfile(viewModel: ContactProfile.ViewModel(contact: contact))) {
                            HStack (alignment: .firstTextBaseline) {
                                Text("\(contact.firstName) \(contact.lastName)")
                                Text("\(contact.level?.name ?? "")").font(.caption).foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        viewModel.deleteContacts(offsets: indexSet)
                    })
                }
                .listStyle(PlainListStyle())
                .onAppear(perform: viewModel.updateContacts)
                .navigationTitle("Contacts")
            }
            .navigationBarItems(trailing: HStack {
                EditButton()
                addContactButton
            }
            )
        }
    }
    
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
    
    /// The contact creation sheet.
    private var newContactSheet: some View {
        NewContactSheet(viewModel: NewContactSheet.ViewModel(), dismissAction: {
            self.showingNewContactSheet = false
            viewModel.updateContacts()
        }
        )
    }
}

struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList()
    }
}
