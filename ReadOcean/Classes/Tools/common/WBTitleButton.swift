//
//  WBTitleButton.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/7/15.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
//MARK: -定义button相对label的位置
enum RGButtonImagePosition {
        case none
        case top          //图片在上，文字在下，垂直居中对齐
        case bottom       //图片在下，文字在上，垂直居中对齐
        case left         //图片在左，文字在右，水平居中对齐
        case right        //图片在右，文字在左，水平居中对齐
}
class WBTittleButton: UIButton {

    
    /// - Description 设置Button图片的位置
        /// - Parameters:
        ///   - style: 图片位置
        ///   - spacing: 按钮图片与文字之间的间隔
        func imagePosition(style: RGButtonImagePosition, spacing: CGFloat) {
            //得到imageView和titleLabel的宽高
            let imageWidth = self.imageView?.frame.size.width
            let imageHeight = self.imageView?.frame.size.height
            
            var labelWidth: CGFloat! = 0.0
            var labelHeight: CGFloat! = 0.0
            
            labelWidth = self.titleLabel?.intrinsicContentSize.width
            labelHeight = self.titleLabel?.intrinsicContentSize.height
            
            //初始化imageEdgeInsets和labelEdgeInsets
            var imageEdgeInsets = UIEdgeInsets.zero
            var labelEdgeInsets = UIEdgeInsets.zero
            
            //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
            switch style {
            case .none:
                imageEdgeInsets = UIEdgeInsets.zero
                labelEdgeInsets = UIEdgeInsets.zero
            case .top:
                //上 左 下 右
                imageEdgeInsets = UIEdgeInsets(top: -labelHeight-spacing/2, left: 0, bottom: 0, right: -labelWidth)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-spacing/2, right: 0)
                break;
                
            case .left:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
                break;
                
            case .bottom:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-spacing/2, right: -labelWidth)
                labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-spacing/2, left: -imageWidth!, bottom: 0, right: 0)
                break;
                
            case .right:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+spacing/2, bottom: 0, right: -labelWidth-spacing/2)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-spacing/2, bottom: 0, right: imageWidth!+spacing/2)
                break;
                
            }
            
            self.titleEdgeInsets = labelEdgeInsets
            self.imageEdgeInsets = imageEdgeInsets
            
        }
//    重载构造函数

    init(title:String?,image:UIImage?) {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        if title == nil {
            setTitle("首页", for: [])
        }else {
            setTitle(title, for: [])
            
            setImage(image, for: [])
            //setImage(UIImage(named: "blue"), for: .selected)
        }
        //设置字体和颜色
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        setTitleColor(UIColor.darkGray, for: [])
        imagePosition(style: .top, spacing: 5)
        
        sizeToFit()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let titleLabel = titleLabel,
            let imageView = imageView else {
                return
        }
//        titleLabel.frame = CGRect(x: 0, y: 0, width: titleLabel.bounds.width, height: bounds.height)
//        imageView.frame = CGRect(x: titleLabel.bounds.width, y: 0, width: imageView.bounds.width, height: bounds.height)
        //也可以这么写
//        titleLabel.frame.origin.y = 0
//        imageView.frame.origin.y = titleLabel.bounds.height
        //imageView.frame.origin.y = 0
        //titleLabel.frame.origin.y = imageView.bounds.height
//        imageView.snp.makeConstraints { (make) in
//            make.left.top.right.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-5)
//            
//        }
//        titleLabel.snp.makeConstraints { (make) in
//            make.top.left.equalTo(imageView)
//        }
    }
}
