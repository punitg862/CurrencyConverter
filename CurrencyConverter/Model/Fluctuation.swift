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

    enum CodingKeys: String, CodingKey {
        case base
        case endDate = "end_date"
        case fluctuation, rates
        case startDate = "start_date"
        case success
    }
}

// MARK: - Rate
struct Rate: Codable {
    let change, changePct, endRate, startRate: Double

    enum CodingKeys: String, CodingKey {
        case change
        case changePct = "change_pct"
        case endRate = "end_rate"
        case startRate = "start_rate"
    }
}
