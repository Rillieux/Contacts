//
//  Contact+Helper.swift
//  Contact
//
//  Created by Dave Kondris on 23/01/21.
//

import Foundation
import CoreData
import Combine

extension Contact {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Category> {
        let request = NSFetchRequest<Category>(entityName: "Contact")
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

    var lastName: String {
        get {
            return lastName_ ?? ""
        }
        set {
            lastName_ = newValue
        }
    }
    
    var initials: String {
        let firstInitial = String(firstName.prefix(1))
        let lastInitial = String(lastName.prefix(1))
        let initials = firstInitial + lastInitial
        return initials
    }

    var age: String? {
        let age = birthdate?.ageInYearsAndMonths
        return age ?? "Indeterminate Age"
    }
}