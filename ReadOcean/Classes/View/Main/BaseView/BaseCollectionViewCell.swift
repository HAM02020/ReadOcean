//
//  BaseCollectionViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/13.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import Reusable

class BaseCollectionViewCell: UICollectionViewCell, Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupLayout() {}

}
