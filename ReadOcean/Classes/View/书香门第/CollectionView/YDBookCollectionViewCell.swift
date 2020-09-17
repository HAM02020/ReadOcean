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
let cellHeight_4 = cellWidth_4*2
let picHeight_4 = cellWidth_4*1.5

let cellWidth_3 = (Double(screenWidth) - cellMargin*2.0 - cellEdgeMargin*2.0)/3
let cellHeight_3 = cellWidth_3*2
let picHeight_3 = cellWidth_3*1.5

let shadowDeep = 3.0

class YDBookCollectionViewCell: BaseCollectionViewCell {
    
    
    private lazy var shadowView:UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: cellWidth_4, height: picHeight_4+shadowDeep))
        

        v.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-shadowDeep)
        }
        settingShadow(v)
        
        
        
        return v
    }()
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth_4, height: picHeight_4))
        iconView.contentMode = .scaleAspectFill
        //iconView.clipsToBounds = true
        settingRoundCorner(iconView)
        
        
        return iconView
    }()
    /// 设置圆角
    @objc private func settingRoundCorner(_ view:UIView) {
        
        //设置圆角
        let roundLayer = CAShapeLayer()
        roundLayer.fillColor = UIColor.red.cgColor
        let rect = view.bounds
        roundLayer.frame = rect
        let roundPath = UIBezierPath(roundedRect: rect, cornerRadius: 5)
        roundLayer.path = roundPath.cgPath
        view.layer.mask = roundLayer
    }
    
    /// 设置阴影
    @objc private func settingShadow(_ shadowView:UIView) {
        // 阴影的厚度
        let size: CGFloat = CGFloat(shadowDeep)
        // 阴影在下方的距离
        let distance: CGFloat = 0
        let rect = CGRect(
            x: shadowView.frame.width/2 - CGFloat(cellWidth_4/2.0)/2,
            y: shadowView.frame.height + distance,
            width: CGFloat(cellWidth_4/2.0),//iconView.frame.width + size * 2,
            height: size
        )
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 7
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        shadowView.layer.masksToBounds = false
        
        
    }
    
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
            //iconView.mg_setImage(urlString: viewModel?.picUrl, placeholderImage: UIImage(named: "placeholder"))
            iconView.sd_setImage(with: URL(string: viewModel?.picUrl ?? ""), placeholderImage: UIImage(named: "placeholder"), options: []) {[weak self] (img, _, _, _) in
                //self?.shadowView.layer.shadowColor = img?.mostColor.cgColor
                self?.shadowView.layer.shadowColor = img?.myMostColor.cgColor
            }
            
        }
    }
    
    
    override func setupLayout(){
        //clipsToBounds = true
        
        
        
        contentView.addSubview(authorLabel)
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(shadowView)
        shadowView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(picHeight_4+shadowDeep)
            //make.height.equalTo(cellHeight_4)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        


    }
    
    func updatePicHeight(_ session:Int) {
        
        var cellWidth = cellWidth_4
        var cellHeight = cellHeight_4
        var picHeight = picHeight_4
        
        
        switch session {
        case 0:
            cellWidth = cellWidth_3
            cellHeight = cellHeight_3
            picHeight = picHeight_3
        default:
            break
        }
        
        shadowView.snp.updateConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(picHeight+shadowDeep)
            //make.height.equalTo(cellHeight_4)
        }
        titleLabel.snp.updateConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        authorLabel.snp.updateConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        iconView.frame = CGRect(x: 0, y: 0, width: cellWidth, height: picHeight)
        shadowView.frame = CGRect(x: 0, y: 0, width: cellWidth, height: picHeight+shadowDeep)
        settingRoundCorner(iconView)
        settingShadow(shadowView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconView.image = nil
    }
}
