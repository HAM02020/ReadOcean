//
//  DiscoverStoryDetailView.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/9/27.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class DiscoverStoryDetailTableViewCell:UITableViewCell{
    
    @IBOutlet weak var icon: UIImageView!{
        didSet{
            icon.layer.cornerRadius = icon.frame.width/2
        }
    }
    
    @IBOutlet weak var labelBG: UIView!{
        didSet{
            labelBG.layer.cornerRadius = labelBG.frame.height/2
            labelBG.layer.maskedCorners = CACornerMask(rawValue: CACornerMask.layerMinXMaxYCorner.rawValue | CACornerMask.layerMaxXMinYCorner.rawValue)
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
//    private lazy var icon:UIImageView = {
//        let img = UIImage(named: "avatar_student")?.reSizeImage(reSize: CGSize(width: 20, height: 20))
//        let imgV = UIImageView(image: img)
//        imgV.layer.cornerRadius = imgV.frame.width/2
//        return imgV
//    }()
//    private lazy var txtLabel : UILabel = {
//        let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
//        txt.text = "我看了《我的妈妈是精灵》，我想问这个世界真的有精灵吗？"
//        txt.font = .monospacedSystemFont(ofSize: 14, weight: .bold)
//        txt.textColor = UIColor.darkGray
//        txt.textAlignment = .left
//
//        txt.adjustsFontForContentSizeCategory = true
//
//        txt.numberOfLines = 1
//        txt.isUserInteractionEnabled = false
//
//        return txt
//    }()
//    private lazy var txtBgView:UIView = {
//        let v = UIView(frame: txtLabel.frame)
//        v.backgroundColor = UIColor(hexString: "f2f4de")
//
//        v.addSubview(txtLabel)
//        txtLabel.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
//
//        return v
//    }()
//
//    override func setupLayout(){
//        addSubview(icon)
//        icon.snp.makeConstraints { (make) in
//            make.left.equalToSuperview()
//            make.centerY.equalToSuperview()
//
//        }
//        addSubview(txtBgView)
//        txtBgView.snp.makeConstraints { (make) in
//            make.left.equalTo(icon.snp.right).offset(10)
//            make.right.equalToSuperview().inset(5)
//            make.top.bottom.equalToSuperview().inset(5)
//        }
//        txtBgView.layer.cornerRadius = txtBgView.frame.height/2
//    }
    
    
}
