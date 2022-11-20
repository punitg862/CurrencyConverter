//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 18/11/22.
//

import Foundation


struct Currencydetails: Codable {
    let symbol, name, symbolNative: String
    let decimalDigits: Int
    let rounding: Double
    let code, namePlural: String

    enum CodingKeys: String, CodingKey {
        case symbol, name
        case symbolNative = "symbol_native"
        case decimalDigits = "decimal_digits"
        case rounding, code
        case namePlural = "name_plural"
    }
}



