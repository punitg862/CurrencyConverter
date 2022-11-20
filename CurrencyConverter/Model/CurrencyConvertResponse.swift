//
//  CurrencyConvertResponse.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 18/11/22.
//

import Foundation


struct CurrencyConvertResponse: Codable {
    let date: String
    let info: Info
    let query: Query
    let result: Double
    let success: Bool
}

// MARK: - Info
struct Info: Codable {
    let rate: Double
    let timestamp: Int
}

// MARK: - Query
struct Query: Codable {
    let amount: Int
    let from, to: String
}
