//
//  Utillclass.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 18/11/22.
//

import UIKit

class Utillclass: NSObject {
    
    static let shared = Utillclass()
    
    private override init() { }
    
    func getJson(complition: @escaping (Dictionary<String, Currencydetails>) -> ()){
        if let path = Bundle.main.path(forResource: "Common-Currency", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decorder = JSONDecoder()
                decorder.keyDecodingStrategy = .convertFromSnakeCase
                if let jsonPetitions = try? decorder.decode(Dictionary<String, Currencydetails>.self, from: data) {
                    complition(jsonPetitions)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func alertWithCustomMessage(_ msg: String, vc: UIViewController) {
        let alertController = UIAlertController.init(title: nil, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OKAY", style: .cancel))
        vc.present(alertController, animated: true)
    }
}

