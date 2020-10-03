//
//  BaseCollectionReusableView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/13.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Reusable
class BaseCollectionReusableView: UICollectionReusableView,Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    open func setupLayout() {}
}
