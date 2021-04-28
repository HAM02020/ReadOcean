//
//  UIImageView + Extensions.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/6/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import SDWebImage


extension UIImageView {
    
    func mg_setImage(urlString:String?,placeholderImage : UIImage?,isAvatar : Bool = false) {
        
        //处理url
        guard let urlString = urlString,
        let url = URL(string: urlString) else {
            //  设置占位图像
            image = placeholderImage
            return
        }
        //print("url setImage =  \(url)")
        
        kf.setImage(with: url, placeholder: placeholderImage, options: nil, progressBlock: nil) {[weak self] (result) in
            switch result {
            case .success(let data):
                //            完成回调 判断是否是头像 设置圆形
                if isAvatar {
                    self?.image = self?.image?.mg_avatarImage(size: self?.bounds.size)
                }
            case .failure(_):
                break
            }
        }
        
        
    }
}
extension UIImage{
    /// 创建头像图像
    /// - Parameters:
    ///   - size: 尺寸
    ///   - backColor: 背景颜色
    ///   - lineColor: 边框颜色
    ///   - isAvatar: 是否头像
    func mg_avatarImage(size:CGSize?,backColor:UIColor = UIColor.white,lineColor:UIColor=UIColor.lightGray) -> UIImage? {
        var size = size
        if size == nil {
            size = self.size
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        //0> 背景填充
        backColor.setFill()
        UIRectFill(rect)
        
        //1> 实例化一个圆形的路径
        let path = UIBezierPath(ovalIn: rect)
        //2> 进行路径裁切 - 后续的绘图都会出现在圆形路径内部，外部的都干掉
        path.addClip()
        //2. 绘图
        draw(in: rect)
        
        //3> 绘制内切的q圆形
        //UIColor.darkGray.setStroke()
        let ovalPath = UIBezierPath(ovalIn: rect)
        ovalPath.lineWidth = 2
        lineColor.setStroke()
        ovalPath.stroke()
        //3. 取得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        //4. 关闭上下文
        UIGraphicsEndImageContext()
        //5. 返回结果
        return result
        
    }
}
