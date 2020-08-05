//
//  UINavigationBar+Extensions.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/7/14.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

let navigationNormalHeight: CGFloat = 44
let navigationExtendHeight: CGFloat = 84

extension UINavigationBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var barHeight: CGFloat = navigationNormalHeight
    
        if size.height == navigationExtendHeight {
            barHeight = size.height
        }
    
        let newSize: CGSize = CGSize(width: self.frame.size.width, height: barHeight)
        return newSize
    }
}
