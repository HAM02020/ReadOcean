//
//  DiscoverBookCollectionViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/21.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class DiscoverBookCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var cover: MGImageView!
    
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
            
            //设置图片
            if viewModel?.image != nil{
                cover.imageView.image = viewModel?.image
                cover.layer.shadowColor = viewModel?.mostColor?.cgColor
            }else{

                guard let urlStr = viewModel?.picUrl,
                      let url = URL(string: urlStr) else{return}
                cover.imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil) {[weak self] (result) in
                    switch result {
                    case .success(let data):
                        data.image.mgMostColor { (mostColor) in
                            self?.cover.layer.shadowColor = mostColor.cgColor
                        }
                        
                    case .failure(_):
                        break
                    }
                }

                
            }
        }
    }
    
}
