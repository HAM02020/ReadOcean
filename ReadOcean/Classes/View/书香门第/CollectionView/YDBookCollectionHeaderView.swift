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
    override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.centerY.height.equalToSuperview()
            make.width.equalTo(200)
        }
    }
}
