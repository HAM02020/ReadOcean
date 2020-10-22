//
//  Global.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

var isIphoneX: Bool {
    
    if #available(iOS 13.0, *){
        let device = UIDevice()
        return device.userInterfaceIdiom == .phone
            && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
                || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
    }else{
        return UI_USER_INTERFACE_IDIOM() == .phone
            && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
                || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
    }
    
}

var statusBarHeight : CGFloat {
    return isIphoneX ? 44 : 20
}

private func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}
//MARK: 全局通知定义

let YDUserShouldLoginNotification = "YDUserShouldLoginNotification"
//用户登陆成功通知
let YDUserLoginSuccessNotification = "YDUserLoginSuccessNotification"
//用户退出登陆通知
let YDUserShouldLogoutNotification = "YDUserShouldLogoutNotification"
//用户退出登陆成功通知
let YDUserLogoutSuccessNotification = "YDUserLogoutSuccessNotification"

//MARK: 全局颜色定义
let bgColor_light = "0ae6b0"
let bgColor_heavy = "23c993"
