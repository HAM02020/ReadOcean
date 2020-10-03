//
//  YDBaseViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import SwiftyJSON


var navHeight:CGFloat = 0

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
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(logoutSuccess(n:)), name: NSNotification.Name(YDUserLogoutSuccessNotification), object: nil)
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
        
        guard let naviHeight = navigationController?.navigationBar.frame.height else {return}
        navHeight = naviHeight
        
     
        
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
        
        networkManager.request(.userInfo()) {[weak self] (result) in
            switch result{
            case .success(let response):
                guard
                    let json = JSON(response.data).dictionaryObject,
                    var userInfo = UserInfo.deserialize(from: json),
                    var url = userInfo.avatar else{return}
                
                if !url.hasPrefix("http"){
                    url = "https://ro.bnuz.edu.cn/user/big/"+url
                    userInfo.avatar = url
                }
                shardAccount.userInfo = userInfo
                self?.viewDidLoad()
            case .failure(_):
                break
            }
            
        }
        
        
        //注销通知 避免通知被重复注册
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func logoutSuccess(n:Notification){
        shardAccount.token = nil
        viewDidLoad()
    }
    
    
    @objc func loginAction(){
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: YDUserShouldLoginNotification), object: nil)
    }
    @objc func logoutAction(){
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: YDUserShouldLogoutNotification), object: nil)
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

