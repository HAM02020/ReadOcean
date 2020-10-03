//
//  BookDetailHeaderView.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/10/3.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BookDetailHeaderView:UIView,NibLoadable{
    
    @IBOutlet weak var bg: UIImageView!{
        didSet{
            bg.image = bg.image?.imageDarken(withLevel: 0.5)
        }
    }
    
    
}
