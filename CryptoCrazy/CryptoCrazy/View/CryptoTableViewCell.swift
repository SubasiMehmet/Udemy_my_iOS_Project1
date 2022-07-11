//
//  CryptoTableViewCell.swift
//  CryptoCrazy
//
//  Created by Mehmet Subaşı on 27.04.2022.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var CurrencyText: UILabel!
    @IBOutlet weak var PriceText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
