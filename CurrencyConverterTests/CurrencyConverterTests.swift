//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Punit Gupta on 18/11/22.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyConverterTests: XCTestCase, CurrencyConverterDelegate, HistoricalDataDelegate {
    
    func getHistoricalData(response: CurrencyConverter.Timeseries?) {
        if let response {
            XCTAssertEqual(response.rates.count, 3)
        }
    }
    
    
    func getResponseCurrency(response: CurrencyConverter.CurrencyConvertResponse?, type: CurrencyConverter.isType) {
        if let response {
            XCTAssertNotNil(response.result)
        }
    }
    

    var vm = CurrencyConverterViewModel()
    var historicalvm = HistoricalDataViewModel()
    
    func testConvertCurrency() {
        
        self.vm.callService(from: "AED", to: "INR", amount: "5", type: .FROM)
    }
    
    func testHistoricalData() {
        self.historicalvm.callService("AED")
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm.delegate = self
        historicalvm.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
