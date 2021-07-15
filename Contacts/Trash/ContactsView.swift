////
////  ContactsView.swift
////  Contacts
////
////  Created by Dave Kondris on 20/04/21.
////
//
//import SwiftUI
//import CoreData
//import os
//
//fileprivate let logger = Logger(subsystem: "com.gymsymbokl.contacts", category: "ContactsView")
//
/////https://stackoverflow.com/questions/57594159/swiftui-navigationlink-loads-destination-view-immediately-without-clicking
//struct LazyView<Content: View>: View {
//    let build: () -> Content
//    init(_ build: @autoclosure @escaping () -> Content) {
//        self.build = build
//    }
//    var body: Content {
//        build()
//    }
//}
//
//struct ContactsView: View {
//    @StateObject private var viewModel: ContactList.ViewModel
//    
//    init(viewModel: ContactList.ViewModel = .init()) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }
//    
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(viewModel.contacts) { contact in
//                    NavigationLink(
//                        destination: LazyView(ContactProfile(contact: contact))) {
//                        Text("\(contact.firstName)")
//                    }
//                }
//            }
//            .navigationBarTitle("Contacts")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading, content: { EditButton() })
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    HStack {
//                        Button(
//                            action: {
//                            print("Add tapped")
//                                viewModel.addContact(name: "Best Contact")
//                            },
//                            label: { Image(systemName: "plus.circle").font(.system(size: 20)) }
//                        )
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct ContactsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactsView()
//    }
//}
