//
//  ContactList.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI

struct ContactList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Contact.lastName_, ascending: true)],
                  animation: .default) private var contacts: FetchedResults<Contact>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name_, ascending: true)],
                  animation: .default) private var categories: FetchedResults<Category>
    
    @State var showingNewContactSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(contacts) { contact in
                        NavigationLink (
                            destination: ContactProfile(contact: contact)) {
                            HStack (alignment: .firstTextBaseline) {
                                Text("\(contact.firstName) \(contact.lastName)")
                                Text("\(contact.category?.name ?? "")").font(.caption).foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: withAnimation { deleteContacts } )
                    
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Contacts")
            .navigationBarItems(trailing:
                                    HStack {
                                        EditButton()
                                        addContactButton
                                    }
            )
            
        }
    }
    
    /// The button that presents the contact creation sheet.
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
    
    /// The athlete creation sheet.
    private var newContactSheet: some View {
        NewContactSheet(
            dismissAction: {
                self.showingNewContactSheet = false
            })
    }
    
    private func deleteContacts(offsets: IndexSet) {
        offsets.map { contacts[$0] }.forEach(viewContext.delete)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList()
    }
}
