//
//  DiscoverBookCollectionViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/21.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class DiscoverBookCollectionViewCell:UICollectionViewCell{
    
    
    @IBOutlet weak var cover: MGRoundCornerShadowImageView!
    
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
    override func prepareForReuse() {
        super.prepareForReuse()
        //异步绘制 离屏渲染
        self.layer.drawsAsynchronously = true
        
        //栅格化
        //必须指定分辨率 不然h很模糊
        self.layer.shouldRasterize = true
        //分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    var viewModel:Book?{
        didSet{
            title.text = viewModel?.name
            author.text = viewModel?.author
            guard let picUrl = viewModel?.picUrl else{return}
            cover.mg_setImage(urlString: picUrl, placeholderImage: UIImage(named: "placeholder"))
            //cover.imageView.image = UIImage(named: "placeholder")
        }
    }
    
}
