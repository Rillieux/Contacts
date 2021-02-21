//
//  CoreData+Helper.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import Foundation



extension NSPredicate {
    
    ///Taken from the Stanford Course CS193p - Developing Applications for iOS using SwiftUI. Lecture 12 Core Data
    ///
    ///See: [Stanford Course CS193p](https://cs193p.sites.stanford.edu/)
    static var all = NSPredicate(format: "TRUEPREDICATE")
    
    ///Taken from the Stanford Course CS193p - Developing Applications for iOS using SwiftUI. Lecture 12 Core Data
    ///
    ///See: [Stanford Course CS193p](https://cs193p.sites.stanford.edu/)
    static var none = NSPredicate(format: "FALSEPREDICATE")
}
