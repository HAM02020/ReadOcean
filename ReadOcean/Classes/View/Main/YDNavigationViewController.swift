//
//  YDNavigationViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/24.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDNavigationViewController: UINavigationController {

    var navHeight:CGFloat?
    
    var pushCount = 0
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //对登陆状态进行判断，如果没有登陆，则弹出登陆界面
        if !userLogon && pushCount > 0 {
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: YDUserShouldLoginNotification), object: nil)
            return
        }
        
        print("pushViewController = \(viewController.title)")
        super.pushViewController(viewController, animated: animated)
        pushCount += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.navHeight = navigationBar.frame.height
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    private func setupUI(){
        

    }
    
    @objc private func btn_click(){
        
    }
}
