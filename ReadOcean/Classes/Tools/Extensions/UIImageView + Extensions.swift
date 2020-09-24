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
                break
            case .failure(_):
                break
            }
        }
        
        
    }
}
