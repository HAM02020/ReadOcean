//
//  BaseTableViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import Reusable
class BaseTableViewCell: UITableViewCell, Reusable {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupLayout()
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style,reuseIdentifier:reuseIdentifier)
        setupLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func setupLayout() {}

}
