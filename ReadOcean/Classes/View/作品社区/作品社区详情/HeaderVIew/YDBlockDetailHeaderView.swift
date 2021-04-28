//
//  YDBlockDetailHeaderView.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/16.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit

class YDBlockDetailHeaderView: UIView,NibLoadable {
    
    var viewModel:MyBlock?{
        didSet{
            guard let viewModel = viewModel else {return}
            coverImageView.mg_setImage(urlString: viewModel.img, placeholderImage: UIImage(named: "placeholder"))
            titleLabel.text = viewModel.title
            authorLabel.text = "作者:" + (viewModel.author ?? "")
            publishHourseLabel.text = "出版社:" + (viewModel.publishingHouse ?? "")
            fitAgeToReadLabel.text = "适读年龄:" + (viewModel.remark ?? "")
            
        }
    }
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishHourseLabel: UILabel!
    @IBOutlet weak var fitAgeToReadLabel: UILabel!

}
