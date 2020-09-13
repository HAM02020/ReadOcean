//
//  YDBaseViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear

        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        setupLayout()

        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: NSNotification.Name(YDUserLoginSuccessNotification), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    func setupLayout() {}

    func configNavigationBar() {
        guard let navi = navigationController else { return }
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            if navi.visibleViewController == self {
                //navi.barStyle(.theme)
                //navi.disablePopGesture = false
                navi.navigationBar.tintColor = .black
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                
                if navi.viewControllers.count > 1{
                
//                navigationItem.backBarButtonItem = UIBarButtonItem(image:UIImage(named: "back")?.withRenderingMode(.alwaysOriginal),style: .plain,target: self,action: #selector(pressBack))
                
                
                }else{
                    navigationController?.setNavigationBarHidden(true, animated: false)
            }
        }
    }
    
    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
    }
    @objc func loginSuccess(n:Notification) {
        print("登陆成功\(n)")
        //更新UI
        //在访问view的getter 时 如果 view == nil 会调用loadview -> viewdidLoad
//        navigationItem.leftBarButtonItem = nil
//        navigationItem.rightBarButtonItem = nil
        
        viewDidLoad()
        
        //注销通知 避免通知被重复注册
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func loginAction(){
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: YDUserShouldLoginNotification), object: nil)
    }
}

extension BaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
    
    func synchronized<T>(_ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }
}

