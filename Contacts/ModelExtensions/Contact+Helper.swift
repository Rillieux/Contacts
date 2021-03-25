//
//  Contact+Helper.swift
//  Contact
//
//  Created by Dave Kondris on 23/01/21.
//

import Foundation
import CoreData
import SwiftUI

extension Contact {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Contact> {
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true), NSSortDescriptor(key: "firstName", ascending: true)]
        request.predicate = predicate
        return request
    }
}

extension Contact {
    var firstName: String {
        get {
            return firstName_ ?? ""
        }
        set {
            firstName_ = newValue
        }
    }
}
