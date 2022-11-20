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
}



