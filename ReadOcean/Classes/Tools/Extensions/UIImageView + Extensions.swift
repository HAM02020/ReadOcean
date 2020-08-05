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
        print("url setImage =  \(url)")
        
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) {
            [weak self](image, _, _, _) in
            
//            完成回调 判断是否是头像 设置圆形
//            if isAvatar {
//                self?.image = image?.mg_avatarImage(size: self?.bounds.size)
//            }
            
            
        }
    }
}
