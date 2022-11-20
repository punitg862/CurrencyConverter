//
//  ServiceCall.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 18/11/22.
//

import Foundation

class ServiceCall {
    
    static let shared = ServiceCall()
    
    private init() {}
    
    typealias successBlock = (_ data:Data?,_ status:Bool)->(Void)
    typealias failureBlock = (String?)->(Void)
    
    
    func getConvertionData(param:Dictionary<String,String>?, success:@escaping (CurrencyConvertResponse?,Bool)->()) {
        callHttpRequest(method: .GET, path: url.currencyConverterURL.rawValue, parameters: param, success:{  (data, status) in
            if status{
                if let data, let json = try? JSONDecoder().decode(CurrencyConvertResponse.self, from: data) {
                    success(json, true)
                }
            } else {
                success(nil,false)
            }
        })
    }
    
    func getTimeseriesData(param:Dictionary<String,String>?, success:@escaping (Timeseries?,Bool)->()) {
        callHttpRequest(method: .GET, path: url.timeseries.rawValue, parameters: param, success:{  (data, status) in
            if status{
                if  let data, let timeseries = try? JSONDecoder().decode(Timeseries.self, from: data) {
                    success(timeseries, true)
                }
            } else {
                success(nil,false)
            }
        })
    }
    
    func getFluctuationData(param:Dictionary<String,String>?, success:@escaping (Fluctuation?,Bool)->()) {
        callHttpRequest(method: .GET, path: url.fluctuation.rawValue, parameters: param, success:{  (data, status) in
            if status{
                if  let data, let timeseries = try? JSONDecoder().decode(Fluctuation.self, from: data) {
                    success(timeseries, true)
                }
            } else {
                success(nil,false)
            }
        })
    }
    
    @discardableResult func callHttpRequest(method: HttpMethod, path:String, parameters:Dictionary<String,String>? = Dictionary<String,String>() , success:@escaping successBlock) -> URLSessionDataTask? {
        
        var urlString = path
        var request = URLRequest(url: URL(string: urlString)!)
        
        if method == .GET, let param = parameters, !param.isEmpty, param.count > 0{
            let urlParams = param.compactMap({ (key, value) -> String in
                return "\(key)=\(value)"
            }).joined(separator: "&")
            
            urlString += urlParams
            request = URLRequest(url: URL(string: urlString)!)
        }
        request.httpMethod = method.rawValue
        request.addValue(APIKey.key.rawValue, forHTTPHeaderField: "apikey")
        request.timeoutInterval = Double.infinity
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                success(nil,false)
                return
            }
            success(data, true)
        }
        task.resume()
        
        return task
    }
}
