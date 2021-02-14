//
//  Date+Helper.swift
//  Contact
//
//  Created by Dave Kondris on 23/01/21.
//

import Foundation

let dobFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()


class AppDateFormatter {
    static let shared = AppDateFormatter()
    
    private init() {}
    
    private let mediumDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        df.locale = Locale.autoupdatingCurrent
        
        return df
    }()
    
    private let mediumTimeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .medium
        df.locale = Locale.autoupdatingCurrent
        
        return df
    }()
    
    private let mediumDateTimeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .medium
        df.locale = Locale.autoupdatingCurrent
        
        return df
    }()

    func mediumDateString(from date: Date) -> String {
        return mediumDateFormatter.string(from: date)
    }
    
    func mediumTimeString(from date: Date) -> String {
        return mediumTimeFormatter.string(from: date)
    }
    
    func mediumDateTimeString(from date: Date) -> String {
        return mediumDateTimeFormatter.string(from: date)
    }
}

extension Date {
    var ageInYearsAndMonths: String {
        var years: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
        var months: Int { Calendar.current.dateComponents([.month], from: self, to: Date()).month! }
        var remainingMonths: Int { months % 12 }
        let yearStr = String(years) + "y "
        let monthsStr = String(remainingMonths) + "m"
        let ageString = yearStr + monthsStr
        return ageString
    }
}
