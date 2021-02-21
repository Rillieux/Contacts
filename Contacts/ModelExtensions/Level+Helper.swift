//
//  Level+Helper.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import Foundation
import CoreData
import UIKit

extension Level {
    var name: String {
        get {
            return name_ ?? ""
        }
        set {
            name_ = newValue
        }
    }
    
    var color: UIColor {
        get {
            guard let hex = colorAsHex else { return .gray }
            return UIColor(hex: hex) ?? .gray
        }
        set(newColor) {
            colorAsHex = newColor.toHex
        }
    }
}

extension Level {
    
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Level> {
        let request = NSFetchRequest<Level>(entityName: "Level")
        request.sortDescriptors = [NSSortDescriptor(key: "sortOrder", ascending: true)]
        request.predicate = predicate
        return request
    }
}

