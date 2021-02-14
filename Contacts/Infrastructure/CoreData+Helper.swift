//
//  CoreData+Helper.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import Foundation

///Stanford Course CS193p - Developing Applications for iOS using SwiftUI. Lecture 12 Core Data
///https://cs193p.sites.stanford.edu/

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}
