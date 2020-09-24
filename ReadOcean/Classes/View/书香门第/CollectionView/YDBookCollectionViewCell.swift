//
//  YDBookCollectionViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//

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
    
    lazy var shadowView:UIView = {
        let v = UIView(frame:coverImg.frame)
        
        let shadowWidth:CGFloat = 5
        let newFrame = CGRect(
            x: v.frame.minX + v.frame.width*0.1,
            y: v.frame.minY + v.frame.height,
            width: v.frame.width*0.8,
            height: shadowWidth)
        let path = UIBezierPath(rect: newFrame)
//        path.move(to: CGPoint(x: 0, y: v.frame.height))
//        path.addLine(to: CGPoint(x: v.frame.width, y: v.frame.height))
        
        v.layer.shadowPath = path.cgPath
        v.layer.shadowRadius = 5
        v.layer.shadowOpacity = 1
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize.zero
        
        
        
        
        v.addSubview(coverImg)
        coverImg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        return v
    }()
    lazy var coverImg:UIImageView = {
        let v = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth_4, height: picHeight_4))
        
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        
        let img = UIImage(named: "placeholder")
        v.image = img
        
        return v
    }()
   
    
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.text = "Swift编程从入门到入土"
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    private lazy var authorLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.text = "作者"
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    var viewModel:Book?{
        didSet{
            titleLabel.text = viewModel?.name
            authorLabel.text = viewModel?.author
            if viewModel?.image != nil{
                coverImg.image = viewModel?.image
                shadowView.layer.shadowColor = viewModel?.mostColor?.cgColor
            }else{

                guard let urlStr = viewModel?.picUrl,
                      let url = URL(string: urlStr) else{return}
                coverImg.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil) {[weak self] (result) in
                    switch result {
                    case .success(let data):
                        data.image.mgMostColor { (mostColor) in
                            self?.shadowView.layer.shadowColor = mostColor.cgColor
                        }
                        
                    case .failure(_):
                        break
                    }
                }

                
            }

        }
    }
//    var shouldLoadImg:Bool = true{
//        didSet{
//            cover.mg_setImage(urlString: viewModel?.picUrl, placeholderImage: UIImage(named: "placeholder"))
//        }
//    }
    
    
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
