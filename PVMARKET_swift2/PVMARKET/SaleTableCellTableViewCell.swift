//
//  SaleTableCellTableViewCell.swift
//  PVMARKET
//
//  Created by Ｃhun-Ying on 2016/6/13.
//  Copyright © 2016年 openopen. All rights reserved.
//

import UIKit

class SaleTableCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var saleImageView: UIImageView!
    @IBOutlet weak var saleTitleLable: UILabel!
    @IBOutlet weak var saleLocationBtn: UIButton!
    
    @IBOutlet weak var saleDirectionLabel: UILabel!

    @IBOutlet weak var saleYearOfOperated: UILabel!
    @IBOutlet weak var priceOfSaleLabel: UILabel!

    @IBOutlet weak var salekWpLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    

}
