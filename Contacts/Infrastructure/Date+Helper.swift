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


///Default birthdate, useful so the user does not have to click so much to geet to a data close to the desired birthdate.
///Offset the deafult date by minus 14 years.
///
/// - Parameter years: the age in years which we subtract from today.
///
/// - Returns: a date "n" years in the past.
///
///For more on Swift functions using a default parameter, see:
///[https://www.hackingwithswift.com/sixty/5/6/default-parameters](https://www.hackingwithswift.com/sixty/5/6/default-parameters)

func defaultBirthDate(years: Int = 14) -> Date {
    let defaultDOB: Date = Calendar.current.date(byAdding: DateComponents(year: -years), to: Date()) ?? Date()
    return defaultDOB
}

func dateIsLessThanOneYear(date: Date) ->  Bool {
    var years: Int { Calendar.current.dateComponents([.year], from: date, to: Date()).year! }
    if years < 1 {
        return true
    } else {
        return false
    }
}

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
    ///Returns a string answering "How many years and months ago was this event / date" from a Date.
    ///
    ///The variable `years` gets the number of whole years since the Date. The variable months shows
    ///the number of whole months left over.
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
