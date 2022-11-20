//
//  HistoricalDataViewModel.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 20/11/22.
//

import Foundation

protocol HistoricalDataDelegate: AnyObject {
    func getHistoricalData(response: Timeseries?)
}

class HistoricalDataViewModel: NSObject {
    
    weak var delegate : HistoricalDataDelegate?
    
    func callService(_ base: String) {
        let endDate = Date().getFormattedDate(format: "yyyy-MM-dd")
        let startDate = Date().dayBefore.getFormattedDate(format: "yyyy-MM-dd")
        
        let param = Dictionary(dictionaryLiteral: ("start_date",startDate),("end_date", endDate),("base",base))

        ServiceCall.shared.getTimeseriesData(param: param) { response, status in
            
            if status {
                self.delegate?.getHistoricalData(response: response)
            }
        }
    }
    
}
