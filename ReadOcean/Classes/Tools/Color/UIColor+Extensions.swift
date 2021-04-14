//
//  UIColor+Extensions.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/24.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
 
extension UIColor {
     
    // MARK: - extension 适配深色模式 浅色模式 非layer
         ///lightHex  浅色模式的颜色（十六进制）
         ///darkHex   深色模式的颜色（十六进制）
         ///return    返回一个颜色（UIColor）
         static func color(lightHex: String, darkHex: String, alpha: CGFloat = 1.0)
             -> UIColor {
             let light = UIColor(hex: lightHex, alpha) ?? UIColor.black
             let dark =  UIColor(hex: darkHex, alpha) ?? UIColor.white
                 
             return color(lightColor: light, darkColor: dark)
         }

         // MARK: - extension 适配深色模式 浅色模式
         ///lightColor  浅色模式的颜色（UIColor）
         ///darkColor   深色模式的颜色（UIColor）
         ///return    返回一个颜色（UIColor）
        static func color(lightColor: UIColor, darkColor: UIColor)-> UIColor {
            if #available(iOS 13.0, *) {
               return UIColor { (traitCollection) -> UIColor in
                    if traitCollection.userInterfaceStyle == .dark {
                        return darkColor
                    }else {
                        return lightColor
                    }
                }
            } else {
               return lightColor
            }
        }

        
    // Hex String -> UIColor
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
         
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
         
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
         
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
         
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
         
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    // MARK: - 构造函数（十六进制）
         ///hex  颜色（十六进制）
         ///alpha   透明度
    convenience init?(hex : String,
                      _ alpha : CGFloat = 1.0) {
        var cHex = hex.trimmingCharacters(in: CharacterSet.whitespaces).uppercased()
        guard cHex.count >= 6 else {
            return nil
        }
        if cHex.hasPrefix("0X") {
            cHex = String(cHex[cHex.index(cHex.startIndex, offsetBy: 2)..<cHex.endIndex])
        }
        if cHex.hasPrefix("#") {
            cHex = String(cHex[cHex.index(cHex.startIndex, offsetBy: 1)..<cHex.endIndex])
        }

        var r : UInt64 = 0
        var g : UInt64  = 0
        var b : UInt64  = 0

        let rHex = cHex[cHex.startIndex..<cHex.index(cHex.startIndex, offsetBy: 2)]
        let gHex = cHex[cHex.index(cHex.startIndex, offsetBy: 2)..<cHex.index(cHex.startIndex, offsetBy: 4)]
        let bHex = cHex[cHex.index(cHex.startIndex, offsetBy: 4)..<cHex.index(cHex.startIndex, offsetBy: 6)]

        Scanner(string: String(rHex)).scanHexInt64(&r)
        Scanner(string: String(gHex)).scanHexInt64(&g)
        Scanner(string: String(bHex)).scanHexInt64(&b)

        self.init(red:CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
         
        let multiplier = CGFloat(255.999999)
         
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
         
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}
