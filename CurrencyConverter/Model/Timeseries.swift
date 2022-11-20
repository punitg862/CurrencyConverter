//
//  Timeseries.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 19/11/22.
//

import Foundation


struct Timeseries: Codable {
    let base, endDate: String
    let rates: [String: [String: Double]]
    let startDate: String
    let success, timeseries: Bool
}

