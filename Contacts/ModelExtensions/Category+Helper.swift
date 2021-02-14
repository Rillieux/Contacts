//
//  Category+Helper.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import Foundation

extension Category {
    
    var name: String {
        get {
            return name_ ?? ""
        }
        set {
            name_ = newValue
        }
    }
}
