//
//  YDBookCollectionViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//学生甲

import UIKit
let cellMargin = 15.0
let cellEdgeMargin = 10.0

let cellWidth_4 = (Double(screenWidth) - cellMargin*3.0 - cellEdgeMargin*2.0)/4
let cellHeight_4 = cellWidth_4*1.9
let picHeight_4 = cellWidth_4*1.35

let cellWidth_3 = (Double(screenWidth) - cellMargin*2.0 - cellEdgeMargin*2.0)/3
let cellHeight_3 = cellWidth_3*2
let picHeight_3 = cellWidth_3*1.5



class YDBookCollectionViewCell: BaseCollectionViewCell {
    
    
//    lazy var cover: MGRoundCornerShadowImageView = {
//        let v = MGRoundCornerShadowImageView(frame: CGRect(x: 0, y: 0, width: cellWidth_4, height: picHeight_4))
//        return v
//    }()
    
    lazy var shadowView:MGImageView = {
        let v = MGImageView(frame: CGRect(x: 0, y: 0, width: cellWidth_4, height: picHeight_4))
        return v
    }()


    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = YDColor.textBlack
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.text = "Swift编程从入门到入土"
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    private lazy var authorLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = YDColor.textlightGray
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.text = "作者"
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    var viewModel:Book?{
        didSet{
            titleLabel.text = viewModel?.name
            authorLabel.text = viewModel?.author
            shadowView.mg_setImage(urlString: viewModel?.picUrl, placeholderImage: UIImage(named: "llplaceholder"))

        }
    }
    
    
    override func setupLayout(){
        //clipsToBounds = true
        
        //异步绘制 离屏渲染
        self.layer.drawsAsynchronously = true
        
        //栅格化
        //必须指定分辨率 不然h很模糊
        self.layer.shouldRasterize = true
        //分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        //优化
        self.layer.isOpaque = true
        
        contentView.addSubview(authorLabel)
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(shadowView)
        shadowView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(picHeight_4)
            //make.height.equalTo(cellHeight_4)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(shadowView.snp.bottom).offset(10)
            make.height.equalTo(15)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        


    }
    
    func updatePicHeight(_ session:Int) {
        
        var cellWidth = cellWidth_4
        var cellHeight = cellHeight_4
        var picHeight = picHeight_4
        
        
        switch session {
        case 0:
//            cellWidth = cellWidth_3
//            cellHeight = cellHeight_3
//            picHeight = picHeight_3
            break
        default:
            break
        }
        
        shadowView.snp.updateConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(picHeight)
            //make.height.equalTo(cellHeight_4)
        }
        titleLabel.snp.updateConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(shadowView.snp.bottom).offset(5)
            make.height.equalTo(10)
        }
        authorLabel.snp.updateConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //coverImg.image = nil
    }
}
