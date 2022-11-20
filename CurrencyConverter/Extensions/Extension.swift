//
//  Extension.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 19/11/22.
//

import Foundation


extension Date {
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: .now)!
    }
    
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
