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
        
        if userLogon{
            didLogon()
        }else{
            didLogout()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)]
    }
    func setupLayout() {}

    func setNavAlpa(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0)), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0))
        navigationController?.navigationBar.isUserInteractionEnabled = false
    }
    
    func configNavigationBar() {
        guard let navi = navigationController else { return }
        
        guard let naviHeight = navigationController?.navigationBar.frame.height else {return}
        navHeight = naviHeight
        
     
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
            //if navi.visibleViewController == self {

                navi.navigationBar.tintColor = .black
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                
                if navi.viewControllers.count > 1{
                
//                navigationItem.backBarButtonItem = UIBarButtonItem(image:UIImage(named: "back")?.withRenderingMode(.alwaysOriginal),style: .plain,target: self,action: #selector(pressBack))
                    navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                    navigationController?.navigationBar.shadowImage = nil
                    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)]
                    navigationController?.navigationBar.isUserInteractionEnabled = true
                
                }else{
                    setNavAlpa()
            }
        //}
    }
    
    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func loginSuccess(n:Notification) {
        print("登陆成功\(n)")
      
//        DispatchQueue.once(token: "\(DispatchTime.now().uptimeNanoseconds/1000000000)") {
        Api.networkManager.request(.userInfo()) {[weak self] (result) in
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
                UserAccount.shardAccount.userInfo = userInfo
                self?.didLogon()
            case .failure(_):
                break
            }
            
        }
       // }
        
        
        
        //注销通知 避免通知被重复注册
        //NotificationCenter.default.removeObserver(self)
    }
    
    @objc func logoutSuccess(n:Notification){
        print("用户退出登陆通知")
        UserAccount.shardAccount.deleteAccount()
//        viewDidLoad()
        didLogout()
        
        //注销通知 避免通知被重复注册
        //NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func loginAction(){
        if(!userLogon){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: YDUserShouldLoginNotification), object: nil)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: YDUserShouldLogoutNotification), object: nil)
        }
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

extension BaseViewController:LogonDelegate{
    func didLogon() {
        
    }
    
    func didLogout() {
        
    }
    
    
}

