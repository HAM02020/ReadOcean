//
//  File.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/23.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit

class YDBookQuestionHeaderView:UIView {
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "这是一道题目"
        l.font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .bold)
        l.textColor = UIColor.white
        l.numberOfLines = 0
        return l
    }()
    
    init(title:String) {
        super.init(frame: CGRect.zero)
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(snp.center)
            make.width.lessThanOrEqualToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
