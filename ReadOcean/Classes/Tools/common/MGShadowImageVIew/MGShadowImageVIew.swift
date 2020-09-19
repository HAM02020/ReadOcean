//
//  MGShadowImageVIew.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/18.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class MGShadowImageVIew:UIView{
    
    let shadowDeep = 4.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-shadowDeep)
        }
        settingRoundCorner(imageView)
        settingShadow(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height+CGFloat(shadowDeep))
        imageView.frame = frame
        
        
    }
    open func updateSV(frame:CGRect){
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        imageView.frame = frame
        settingRoundCorner(imageView)
        settingShadow(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = false
        
        
        
        return iconView
    }()
    /// 设置圆角
    @objc private func settingRoundCorner(_ view:UIView) {
        
        //设置圆角
        let roundLayer = CAShapeLayer()
        roundLayer.fillColor = UIColor.red.cgColor
        let rect = view.frame
        roundLayer.frame = rect
        let roundPath = UIBezierPath(roundedRect: rect, cornerRadius: 5)
        roundLayer.path = roundPath.cgPath
        view.layer.mask = roundLayer
    }
    
    /// 设置阴影
    @objc private func settingShadow(_ shadowView:UIView) {
        // 阴影的厚度
        let size: CGFloat = CGFloat(shadowDeep)
        // 阴影在下方的距离
        let distance: CGFloat = -1
        let rect = CGRect(
            x: shadowView.frame.width/2 - CGFloat(shadowView.bounds.width-20)/2,
            y: shadowView.frame.height + distance,
            width: CGFloat(shadowView.bounds.width*0.8),//iconView.frame.width + size * 2,
            height: size
        )
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        shadowView.layer.masksToBounds = false
        
        
    }
    
    func mg_setImage(urlString:String?,placeholderImage : UIImage?) {
            
            //处理url
            guard let urlString = urlString,
            let url = URL(string: urlString) else {
                //  设置占位图像
                imageView.image = placeholderImage
                return
            }
            //print("url setImage =  \(url)")
            
            imageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) {
                [weak self](image, _, _, _) in
                
                DispatchQueue.main.async {
                    self?.layer.shadowColor = self?.imageView.image?.myMostColor.cgColor
                }
                
            }
        }
}
