//
//  CALayer + Extensions.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/9/27.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

extension CALayer{
    func setupCornerShadow(_ view:UIView){
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5

        //制作阴影
        let subLayer = CALayer()
        let fixframe = view.frame
        let newFrame = CGRect(x: fixframe.minX, y: fixframe.minY, width: fixframe.width, height: fixframe.height) // 修正偏差
        subLayer.frame = newFrame
        subLayer.cornerRadius = view.layer.cornerRadius
        subLayer.backgroundColor = UIColor.white.cgColor
        subLayer.masksToBounds = false
        subLayer.shadowColor = UIColor.black.cgColor // 阴影颜色
        subLayer.shadowOffset = CGSize(width: 0, height: 0) // 阴影偏移,width:向右偏移3，height:向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
        subLayer.shadowOpacity = 0.2 //阴影透明度
        subLayer.shadowRadius = 5;//阴影半径，默认3
        //view.layer.addSublayer(subLayer)
        guard let sublayers = view.superview?.layer.sublayers else {
            view.superview?.layer.insertSublayer(subLayer, below: view.layer)
            return
        }
        for s in sublayers {
            if s.shadowRadius == subLayer.shadowRadius {
                return
            }
        }
        view.superview?.layer.insertSublayer(subLayer, at: 0)
        
    }
}
