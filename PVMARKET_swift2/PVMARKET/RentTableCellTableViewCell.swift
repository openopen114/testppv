//
//  RentTableCellTableViewCell.swift
//  PVMARKET
//
//  Created by open open on 2016/5/24.
//  Copyright (c) 2016年 openopen. All rights reserved.
//

import UIKit

class RentTableCellTableViewCell: UITableViewCell {

//    @IBOutlet weak var testBtn: UIButton!
//    @IBOutlet weak var testLabel: UILabel!
    
    
    
    @IBOutlet weak var rentImageView: UIImageView!
    @IBOutlet weak var rentTitleLable: UILabel!
    @IBOutlet weak var rentLocationBtn: UIButton!
    @IBOutlet weak var rentDirectionBtn: UIButton!
    @IBOutlet weak var rentSizeBtn: UIButton!
    
    
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
