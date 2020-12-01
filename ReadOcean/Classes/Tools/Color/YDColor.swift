//
//  ColorConfig.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/11/16.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

public struct YDColor{
    ///黑色字体色
    public static var textBlack: UIColor = {
        return UIColor.color(lightHex: "333333", darkHex: "FFFFFF")
    }()
    ///深灰色字体色
    public static var textDarkGray: UIColor = {
        return UIColor.color(lightHex: "666666", darkHex: "666666")
    }()
    ///浅灰色字体色
    public static var textlightGray: UIColor = {
        return UIColor.color(lightHex: "999999", darkHex: "999999")
    }()
    ///深色分割线Separator
    public static var separatorDark: UIColor = {
        return UIColor.color(lightHex: "cccccc", darkHex: "999999")
    }()
    ///浅色分割线Separator
    public static var separatorLight: UIColor = {
        return UIColor.color(lightHex: "E5E5E5", darkHex: "999999")
    }()
    ///背景颜色
    public static var backgroundNormal: UIColor = {
        return UIColor.color(lightHex: "fefefe", darkHex: "191919")
    }()
    ///背景颜色
    public static var backgroundLight: UIColor = {
        return UIColor.color(lightHex: "FFFFFF", darkHex: "202020")
    }()
    ///背景颜色
    public static var backgroundBlack: UIColor = {
        return UIColor.color(lightHex: "ffffff", darkHex: "000000")
    }()
}

