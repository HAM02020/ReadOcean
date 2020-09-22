//
//  DiscoverBookCollectionViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/21.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class DiscoverBookCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var cover: UIImageView!{
        didSet{
            cover.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var rank: UIImageView!{
        didSet{
            rank.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
          
    }
    
    var viewModel:Book?{
        didSet{
            title.text = viewModel?.name
            author.text = viewModel?.author
            cover.mg_setImage(urlString: viewModel?.picUrl, placeholderImage: nil)
        }
    }
    
}
