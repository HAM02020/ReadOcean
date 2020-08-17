//
//  YDBookCollectionHeaderView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/13.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDBookCollectionHeaderView : BaseCollectionReusableView{

    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.text = "推荐书籍"
        return titleLabel
    }()
    private lazy var loginView:UIView = {
       let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 5
        v.layer.borderColor = UIColor.clear.cgColor
        v.layer.borderWidth = 0.5
        
        v.layer.shadowColor = UIColor.darkGray.cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 5)
        v.layer.shadowOpacity = 0.4
        v.layer.shadowRadius = 5
        return v
    }()
    override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(200)
        }

    }
   
    
}
