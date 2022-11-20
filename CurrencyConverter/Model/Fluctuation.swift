//
//  Fluctuation.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 19/11/22.
//

import Foundation

struct Fluctuation: Codable {
    let base, endDate: String
    let fluctuation: Bool
    let rates: [String: Rate]
    let startDate: String
    let success: Bool
}

// MARK: - Rate
struct Rate: Codable {
    let change, changePct, endRate, startRate: Double
}
