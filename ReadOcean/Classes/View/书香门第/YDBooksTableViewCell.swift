//
//  YDBooksCollectionViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/6/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDBooksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var label2: UILabel!
    
    var vm1 : YDBookViewModel?{
        didSet{
            img1.mg_setImage(urlString: vm1?.book.picUrl, placeholderImage: nil)
            label1.text = vm1?.book.name
        }
    }
    var vm2 : YDBookViewModel?{
        didSet{
            img2.mg_setImage(urlString: vm2?.book.picUrl, placeholderImage: nil)
            label2.text = vm2?.book.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

}
