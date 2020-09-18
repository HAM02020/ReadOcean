//
//  BookCollectionViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/18.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var shadowView: UIView!{
        didSet{
            // 阴影的厚度
            let size: CGFloat = CGFloat(3)
            // 阴影在下方的距离
            let distance: CGFloat = 1
            print("shadowView frame: width:\(shadowView.frame.width) height:\(shadowView.frame.height)")
            print("screen width:\(UIScreen.main.bounds.width) height:\(UIScreen.main.bounds.height)")
            let rect = CGRect(
                x: shadowView.frame.width/2 - CGFloat(shadowView.bounds.width-20)/2,
                y: shadowView.frame.height + distance,
                width: CGFloat(shadowView.bounds.width-20),//iconView.frame.width + size * 2,
                height: size
            )
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowRadius = 5
            shadowView.layer.shadowOpacity = 1
            shadowView.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
            //shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
            shadowView.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var coverView: UIImageView!{
        didSet{
            //设置圆角
            let roundLayer = CAShapeLayer()
            roundLayer.fillColor = UIColor.red.cgColor
            let rect = coverView.frame
            roundLayer.frame = rect
            let roundPath = UIBezierPath(roundedRect: rect, cornerRadius: 5)
            roundLayer.path = roundPath.cgPath
            coverView.layer.mask = roundLayer
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
            //iconView.mg_setImage(urlString: viewModel?.picUrl, placeholderImage: UIImage(named: "placeholder"))
            coverView.sd_setImage(with: URL(string: viewModel?.picUrl ?? ""), placeholderImage: nil, options: []) {[weak self] (img, _, _, _) in
//                self?.shadowView.layer.shadowColor = img?.myMostColor.cgColor
            }
            
        }
    }
    
}
