//
//  YDMGShadowImageView.swift
//  ReadOcean
//
//  Created by HAM02020 on 2020/9/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import Kingfisher

/// 阴影样式
enum ShadowType {
    //底部弧形
    case bottomCurve
    //四周矩形
    case rect
}
/// 圆角阴影共存的ImageView
class MGRoundCornerShadowImageView: UIImageView {

    let subLayer = CALayer()
    
    override var image: UIImage?{
        didSet{
            guard let image = image else {return}
            subLayer.shadowColor = image.myMostColor.cgColor
        }
    }
    
    var shadowType:ShadowType = .bottomCurve
    
    /// 被添加到父视图时setupLayer
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLayer()
    }
    /// 当位置发生改变时修正sublayer
    override func layoutSubviews() {
        super.layoutSubviews()
        fixLayer()
    }
    convenience init(frame:CGRect,shadowType:ShadowType = .bottomCurve){
        self.init(frame:frame)
        self.shadowType = shadowType
    }
    
    override private init(frame: CGRect) {
        super.init(frame:frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
}
// MARK: 方法
extension MGRoundCornerShadowImageView{
    
    func config(){
        self.contentMode = .scaleAspectFill

        //异步绘制 离屏渲染
        self.layer.drawsAsynchronously = true
        
        //栅格化
        self.layer.shouldRasterize = true
        //分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        //优化
        self.layer.isOpaque = true
    }
    
    /// 修正layer
    func fixLayer(){
        
        let fixframe = self.frame
        let newFrame = CGRect(x: fixframe.minX, y: fixframe.minY,width: fixframe.width, height: fixframe.height)
        //print("minX = \(fixframe.minX) minY = \(fixframe.minY) width = \(fixframe.width) height = \(fixframe.height)")
        subLayer.frame = newFrame
    }
    
    /// 创建layer
    func setupLayer(){
        
        let fixframe = self.frame
        let newFrame = CGRect(x: fixframe.minX, y: fixframe.minY, width: fixframe.width, height: fixframe.height)
        // 修正偏差
        subLayer.frame = newFrame
        //settingRoundCorner()
        //settingShadow()
        self.superview?.layer.insertSublayer(subLayer, below: self.layer)

    }
    
    /// 设置圆角
    private func settingRoundCorner() {
        //设置圆角
        let roundLayer = CAShapeLayer()
        roundLayer.fillColor = UIColor.red.cgColor
        
        let fixframe = self.frame
        let newFrame = CGRect(x: fixframe.minX, y: fixframe.minY, width: fixframe.width, height: fixframe.height)
        
        roundLayer.frame = newFrame
        let roundPath = UIBezierPath(roundedRect: newFrame, cornerRadius: 6)
        roundLayer.path = roundPath.cgPath
        self.layer.mask = roundLayer

    }
    
    /// 设置阴影
    private func settingShadow() {
        
        switch shadowType {
        case .bottomCurve:
            setupBottomCurveShadow()
        case .rect:
            setupRectShadow()
        }
        
        
    }
    private func setupRectShadow(){
        subLayer.shadowRadius = 5
        subLayer.shadowOffset = CGSize(width: 1, height: 1)
        subLayer.shadowOpacity = 0.5
        subLayer.shadowColor = UIColor.black.cgColor
        subLayer.shadowPath = UIBezierPath(rect: self.frame).cgPath
        subLayer.masksToBounds = false
    }
    private func setupBottomCurveShadow(){
        // 曲形阴影的曲度
        let curve: CGFloat = self.frame.height*0.1
        let border:CGFloat = self.frame.width*0.1
        //let shadowPath = UIBezierPath(rect: self.frame)
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: border, y: self.frame.height-curve))
        shadowPath.addCurve(
                    to: CGPoint(
                        x: self.frame.width-border,
                        y: self.frame.height - curve
                    ),
                    controlPoint1: CGPoint(
                        x: border,
                        y: self.frame.height
                    ),
                    controlPoint2: CGPoint(
                        x: self.frame.width - border,
                        y: self.frame.height
                    )
                )

        subLayer.shadowPath = shadowPath.cgPath
        subLayer.shadowRadius = 2
        subLayer.shadowOffset = CGSize(width: 0, height: self.frame.height*0.05)
        subLayer.shadowOpacity = 0.6
        subLayer.shadowColor = UIColor.black.cgColor
        subLayer.masksToBounds = false
    }
    func mg_setImage(urlString:String?,placeholderImage : UIImage?) {
        
        //处理url
        guard let urlString = urlString,
        let url = URL(string: urlString) else {
            //  设置占位图像
            self.image = placeholderImage
            return
        }
        //print("url setImage =  \(url)")
        
//    self.sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) {
//            [weak self](image, _, _, _) in
//
//            DispatchQueue.main.async {
//                self?.subLayer.shadowColor = image?.myMostColor.cgColor
//            }
//
//        }
        self.kf.setImage(with: url, placeholder: placeholderImage, options: nil, progressBlock: nil) {[weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.subLayer.shadowColor = data.image.myMostColor.cgColor
                }
            case .failure(_):
                break
            }
        }
//        KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, downloadTaskUpdated: nil) {[weak self] (result) in
//            switch result{
//            case .success(let data):
//
//                DispatchQueue.main.async {
//                    self?.image = data.image
//                    self?.subLayer.shadowColor = data.image.myMostColor.cgColor
//                }
//            case .failure(_):
//                break
//            }
//        }
    }
    
}


