//
//  MGImageView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/25.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class MGImageView:UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    

    
    lazy var imageView:UIImageView = {
        let v = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth_4, height: picHeight_4))
        
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        
        let img = UIImage(named: "placeholder")
        v.image = img
        
        return v
    }()
    
    func setupLayout(){
        let shadowWidth:CGFloat = 5
        let newFrame = CGRect(
            x: frame.minX + frame.width*0.1,
            y: frame.minY + frame.height - shadowWidth/2,
            width: frame.width*0.8,
            height: shadowWidth)
        let path = UIBezierPath(rect: newFrame)
//        path.move(to: CGPoint(x: 0, y: v.frame.height))
//        path.addLine(to: CGPoint(x: v.frame.width, y: v.frame.height))
        
        layer.shadowPath = path.cgPath
        layer.shadowRadius = frame.height*0.05 < 6 ? frame.height*0.05 : 6
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        
        layer.masksToBounds = false
        
        //异步绘制 离屏渲染
        layer.drawsAsynchronously = true
        //栅格化
        layer.shouldRasterize = true
        //分辨率
        layer.rasterizationScale = UIScreen.main.scale
        //优化
        layer.isOpaque = true
        
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
}

extension MGImageView{
    func mg_setImage_withoutMostColor(urlString:String?,placeholderImage : UIImage?) {
        
        //处理url
        guard let urlString = urlString,
        let url = URL(string: urlString) else {
            //  设置占位图像
            self.imageView.image = placeholderImage
            return
        }

        self.imageView.kf.setImage(with: url, placeholder: placeholderImage, options: nil, progressBlock: nil) { (_) in
            
            }
        }

    func mg_setImage(urlString:String?,placeholderImage : UIImage?) {
        
        //处理url
        guard let urlString = urlString,
        let url = URL(string: urlString) else {
            //  设置占位图像
            self.imageView.image = placeholderImage
            return
        }

        self.imageView.kf.setImage(with: url, placeholder: placeholderImage, options: nil, progressBlock: nil) {[weak self] (result) in
            switch result {
            case .success(let data):
                data.image.mgMostColor { (color) in
                    self?.layer.shadowColor = color.cgColor
                }
                
            case .failure(_):
                break
            }
        }

    }
}

extension UIImage {
    
    open func mgMostColor(completion:@escaping(_ mostColor:UIColor)->Void){
        let myQueue = DispatchQueue(label:"myQueue")
        myQueue.async {
            let color = self.myMostColor
            DispatchQueue.main.async {
                completion(color)
            }
            
        }
    }
    
    var myMostColor:UIColor{
        
        let colors = self.dominantColors()

        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 0

        for color in colors{
            r += color.r
            g += color.g
            b += color.b
            a += color.a
        }
        r = r/CGFloat(colors.count)
        g = g/CGFloat(colors.count)
        b = b/CGFloat(colors.count)
        a = a/CGFloat(colors.count)
        return UIColor(displayP3Red: r, green: g, blue: b, alpha: a)
        
        
    }
    
    
    
    
   
}
//UIColor的延展
  //将color转换成RGB
extension UIColor {
    
    var r:CGFloat{
        
        return self.cgColor.components.red;
    }
    var g:CGFloat{
        
        return self.cgColor.components.green;
    }
    var b:CGFloat{
        
        return self.cgColor.components.blue;
    }
    var a:CGFloat{
        
        return self.cgColor.components.alpha;
    }
    
    
}
