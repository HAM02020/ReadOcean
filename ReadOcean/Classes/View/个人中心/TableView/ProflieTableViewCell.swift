//
//  ProflieTableViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/10.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class ProfileTableViewCell : BaseTableViewCell{
    
    private lazy var iconView:UIImageView = {
        let img = UIImage(named: "oceanworld")//?.reSizeImage(reSize: CGSize(width: 50, height: 50))
        let imgV = UIImageView(image: img)
        
        return imgV
    }()
    private lazy var titleLabel:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "个人信息"
        txt.font = .monospacedSystemFont(ofSize: 16, weight: .regular)
        txt.textColor = .black
        txt.textAlignment = .left
        txt.numberOfLines = 0
        return txt
    }()
    private lazy var arrow:UIImageView = {
        let img = UIImage(named: "arrow_right")//?.reSizeImage(reSize: CGSize(width: 50, height: 50))
        let imgV = UIImageView(image: img)
        
        return imgV
    }()
    
    var viewModel:PModel?{
        didSet{
            let img = UIImage(named: viewModel?.iconName ?? "")?.reSizeImage(reSize: CGSize(width: 25, height: 25))
            iconView.image = img
            titleLabel.text = viewModel?.title
        }
    }
    
    override func setupLayout() {
        backgroundColor = UIColor.white
        selectionStyle = .none
        addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(25)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconView.snp.centerY)
            make.left.equalTo(iconView.snp.right).offset(15)
        }
        addSubview(arrow)
        arrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalToSuperview().offset(-15)
            make.width.height.equalTo(20)
        }
    }
}
