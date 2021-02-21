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
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Level> {
        let request = NSFetchRequest<Level>(entityName: "Contact")
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
    
    ///This returns the first letters of the firstNAme and lastName
    ///attributes of the Contact entity.
    ///
    ///For example, "George Washington" would have the initials "GW"
    var initials: String {
        let firstInitial = String(firstName.prefix(1))
        let lastInitial = String(lastName.prefix(1))
        let initials = firstInitial + lastInitial
        return initials
    }

    var age: String? {
        let age = birthdate?.ageInYearsAndMonths
        return age ?? "Unknown Age"
    }
}
