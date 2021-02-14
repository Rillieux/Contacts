//
//  ContactsApp.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI

@main
struct ContactsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
