//
//  YDProfileTableViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/9.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit

class YDProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var titile: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
