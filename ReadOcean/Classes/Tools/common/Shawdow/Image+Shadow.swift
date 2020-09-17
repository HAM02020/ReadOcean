//
//  Image+Shadow.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/17.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit


extension UIImage {
    
    
    var myMostColor:UIColor{
        let cube = CCColorCube()
        //let imgColors = cube.extractBrightColors(from: self, avoid: UIColor.white, count: 100)
        let imgColors = cube.extractColors(from: self, flags: CCFlags(CCAvoidWhite.rawValue), count: 4)
        guard let colors = imgColors
        else {return UIColor()}
        
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
        return UIColor(displayP3Red: r*0.9, green: g, blue: b, alpha: a)
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
