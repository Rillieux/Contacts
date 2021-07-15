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
    var firstName: String {
        get {
            return firstName_ ?? ""
        }
        set {
            firstName_ = newValue
        }
    }
}
