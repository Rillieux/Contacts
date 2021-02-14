//
//  Color+Helper.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI

extension Color {
    static let accentColor = Color("AccentColor")
}

///https://cocoacasts.com/how-to-store-uicolor-in-core-data-persistent-store
///with some adjustments as found here: https://stackoverflow.com/questions/57870527/scanhexint32-was-deprecated-in-ios-13-0
///See Daniel Storm's answer: "Update to use UInt64 and scanHexInt64:"
extension UIColor {
    
    // MARK: - Initialization
    
    convenience init?(hex: String) {
        //        print("hex: String")
        var hexNormalized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexNormalized = hexNormalized.replacingOccurrences(of: "#", with: "")
        
        // Helpers
        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        let length = hexNormalized.count
        
        // Create Scanner
        Scanner(string: hexNormalized).scanHexInt64(&rgb)
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    var toHex: String? {
        //        print("toHex: String?")
        
        // Extract Components
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        // Helpers
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        // Create Hex String
        let hex = String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        
        return hex
    }
}

extension Color {
    
    static var label: Color {
        return Color(UIColor.label)
    }
    
    static var secondaryLabel: Color {
        return Color(UIColor.secondaryLabel)
    }
    
    static var tertiaryLabel: Color {
        return Color(UIColor.tertiaryLabel)
    }
    
    static var quaternaryLabel: Color {
        return Color(UIColor.quaternaryLabel)
    }
    
    static var systemFill: Color {
        return Color(UIColor.systemFill)
    }
    
    static var secondarySystemFill: Color {
        return Color(UIColor.secondarySystemFill)
    }
    
    static var tertiarySystemFill: Color {
        return Color(UIColor.tertiarySystemFill)
    }
    
    static var quaternarySystemFill: Color {
        return Color(UIColor.quaternarySystemFill)
    }
    
    static var systemBackground: Color {
        return Color(UIColor.systemBackground)
    }
    
    static var secondarySystemBackground: Color {
        return Color(UIColor.secondarySystemBackground)
    }
    
    static var tertiarySystemBackground: Color {
        return Color(UIColor.tertiarySystemBackground)
    }
    
    static var systemGroupedBackground: Color {
        return Color(UIColor.systemGroupedBackground)
    }
    
    static var secondarySystemGroupedBackground: Color {
        return Color(UIColor.secondarySystemGroupedBackground)
    }
    
    static var tertiarySystemGroupedBackground: Color {
        return Color(UIColor.tertiarySystemGroupedBackground)
    }
    
    static var systemRed: Color {
        return Color(UIColor.systemRed)
    }
    
    static var systemBlue: Color {
        return Color(UIColor.systemBlue)
    }
    
    static var systemPink: Color {
        return Color(UIColor.systemPink)
    }
    
    static var systemTeal: Color {
        return Color(UIColor.systemTeal)
    }
    
    static var systemGreen: Color {
        return Color(UIColor.systemGreen)
    }
    
    static var systemIndigo: Color {
        return Color(UIColor.systemIndigo)
    }
    
    static var systemOrange: Color {
        return Color(UIColor.systemOrange)
    }
    
    static var systemPurple: Color {
        return Color(UIColor.systemPurple)
    }
    
    static var systemYellow: Color {
        return Color(UIColor.systemYellow)
    }
    
    static var systemGray: Color {
        return Color(UIColor.systemGray)
    }
    
    static var systemGray2: Color {
        return Color(UIColor.systemGray2)
    }
    
    static var systemGray3: Color {
        return Color(UIColor.systemGray3)
    }
    
    static var systemGray4: Color {
        return Color(UIColor.systemGray4)
    }
    
    static var systemGray5: Color {
        return Color(UIColor.systemGray5)
    }
    
    static var systemGray6: Color {
        return Color(UIColor.systemGray6)
    }
    
}
