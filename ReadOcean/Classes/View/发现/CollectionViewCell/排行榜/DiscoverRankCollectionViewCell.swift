//
//  DiscoverRankCollectionViewCell.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/9/28.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class DiscoverRankCollectionViewCell:UICollectionViewCell{
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        //layer.setupCornerShadow(self)
        self.layer.cornerRadius = 5
    }
    
    @IBOutlet weak var view: UIView!{
        didSet{
            //contentView.layer.cornerRadius = 5
            
//            layer.shadowColor = UIColor.black.cgColor
//            layer.shadowRadius = 5
//            layer.shadowOffset = CGSize(width: 1, height: 1)
//            layer.shadowOpacity = 0.2
//            layer.masksToBounds = false
        }
    }
    
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var rankName: UILabel!
    
    @IBOutlet weak var descriptLabel: UILabel!
    
    @IBOutlet weak var line: UIView!
    
    
    @IBAction func moreBtnClick(_ sender: Any) {
        //打开排行榜列表
        
    }
    
    
    var rankType:String?{
        didSet{
            var imgStr = ""
            var rankStr = ""
            var descript = ""
            switch rankType {
            
            case "book":
                imgStr = "shuxiangbang"
                rankStr = "书香榜"
                descript = "看看哪个同学读书最多"
            case "point":
                imgStr = "jifenbang"
                rankStr = "积分榜"
                descript = "完成的任务数越多，积分越高哦！"
            case "community":
                imgStr = "shequbang"
                rankStr = "社区榜"
                descript = "快来跟社区小伙伴比拼吧"
            default:
                break
            }
            cover.image = UIImage(named: imgStr)
            rankName.text = rankStr
            descriptLabel.text = descript
            

        }
        
    }
}
