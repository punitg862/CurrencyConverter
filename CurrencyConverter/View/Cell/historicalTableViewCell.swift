//
//  historicalTableViewCell.swift
//  CurrencyConverter
//
//  Created by Punit Gupta on 20/11/22.
//

import UIKit

class historicalTableViewCell: UITableViewCell {

    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var countryCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
