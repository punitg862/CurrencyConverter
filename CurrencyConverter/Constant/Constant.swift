//
//  Constant.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 18/11/22.
//

import Foundation


enum url : String{
    case currencyConverterURL = "https://api.apilayer.com/fixer/convert?"
    case timeseries = "https://api.apilayer.com/fixer/timeseries?"
    case fluctuation = "https://api.apilayer.com/fixer/fluctuation?"
}

enum HttpMethod:String {
    case GET = "GET"
    case POST = "POST"
}

enum APIKey: String {
    case key = "dDag3Q24ZsNidtMDIOSOJzZua146CFvL"
}
