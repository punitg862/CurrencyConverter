//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 20/11/22.
//

import UIKit

protocol CurrencyConverterDelegate : AnyObject {
    func keyboardDoneTapped()
    func getResponseCurrency(response: CurrencyConvertResponse?, type: isType)
}

class CurrencyConverterViewModel: NSObject {

    weak var delegate : CurrencyConverterDelegate?
    
    func addToolBar( textfield: UITextField) {
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexibleSpace,reset]
        bar.sizeToFit()
        textfield.inputAccessoryView = bar
    }
    
    @objc func doneTapped() {
        delegate?.keyboardDoneTapped()
    }
    
    func callService(from: String, to: String, amount: String, type: isType) {
        let param = Dictionary(dictionaryLiteral: ("from",from),("to", to),("amount",amount))
        ServiceCall.shared.getConvertionData(param: param) { response, status in
            self.delegate?.getResponseCurrency(response: response, type: type)

        }
    }
}

enum isType:String {
    case FROM = "from"
    case TO = "to"
}
