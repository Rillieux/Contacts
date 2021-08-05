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
}
