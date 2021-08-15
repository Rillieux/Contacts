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
    var givenName: String {
        get {
            return givenName_ ?? ""
        }
        set {
            givenName_ = newValue
        }
    }
    var middleName: String {
        get {
            return middleName_ ?? ""
        }
        set {
            middleName_ = newValue
        }
    }
    var familyName: String {
        get {
            return familyName_ ?? ""
        }
        set {
            familyName_ = newValue
        }
    }
    var nickname: String {
        get {
            return nickname_ ?? ""
        }
        set {
            nickname_ = newValue
        }
    }
}
