//
//  HistoricalDataVC.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 19/11/22.
//

import UIKit

class HistoricalDataVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var base = ""
    var list: Timeseries?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(base) last 3 days"
        callService()
    }

    func callService() {
        let endDate = Date().getFormattedDate(format: "yyyy-MM-dd")
        let startDate = Date().dayBefore.getFormattedDate(format: "yyyy-MM-dd")
        
        let param = Dictionary(dictionaryLiteral: ("start_date",startDate),("end_date", endDate),("base",base))

        ServiceCall.shared.getTimeseriesData(param: param) { response, status in
            if status, let response {
                self.list = response
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension HistoricalDataVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let list {
            return list.rates.keys.map({$0})[section] }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let list {
            return list.rates.count }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list {
            return list.rates.values.map({$0})[section].count }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historicalTableViewCell", for: indexPath) as! historicalTableViewCell
        if let list {
            let singleData = list.rates.values.map({$0})[indexPath.section].map({$0})[indexPath.row]

            cell.countryCode.text = "\(singleData.key)"
            cell.currency.text = "\(singleData.value)"
        }
        return cell
    }
}


