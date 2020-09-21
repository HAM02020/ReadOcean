//
//  YDMainViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit





class YDMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: YDUserShouldLoginNotification), object: nil)
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogout), name: NSNotification.Name(YDUserShouldLogoutNotification), object: nil)

    }
    
    deinit {
        //注销通知
        NotificationCenter.default.removeObserver(self)
    }
    @objc private func userLogout(n:Notification){
        print("用户退出登陆通知\(n)")
        //第一个参数是标题,第二个参数是消息内容,第三个参数就是上2张图中的样式,随便选一个.
        let alertViewController = UIAlertController(title: "退出后不会删除任何历史数据，下次登陆依然可以使用本账号。", message: nil, preferredStyle: .actionSheet)

        //如果没有调用addAction方法, 对话框也是会显示的.但是没有可以点击的按钮.
        alertViewController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { action in print("onAction") }))

        //UIAlertAction的第二个参数是 按钮的样式(取消(粗体显示),消极(红色显示),正常)3种样式.
        //第三个参数是一个函数类型的参数. 表示点击按钮之后的调用的方法.

        alertViewController.addAction(UIAlertAction(title: "退出登陆", style: .destructive, handler: { action in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: YDUserLogoutSuccessNotification), object: nil)
            
        }))
        //显示对话框
        self.present(alertViewController, animated: true, completion: nil)
    }
    @objc private func userLogin(n:Notification) {
        print("用户登陆通知\(n)")
        
        var when = DispatchTime.now()
        
        //如果有值 判断 提示用户重新登陆
        if n.object != nil {
            //渐变样式
//            SVProgressHUD.setDefaultMaskType(.gradient)
//
//            SVProgressHUD.showInfo(withStatus: "用户登陆已经超时，需要重新登陆")
            
            when = DispatchTime.now() + 2

        }
        DispatchQueue.main.asyncAfter(deadline: when) {
            //SVProgressHUD.setDefaultMaskType(.clear)
            //展现登陆控制器
            
        }
        let nav = UINavigationController(rootViewController: LoginVC())
        nav.modalPresentationStyle = .fullScreen
        self.modalPresentationStyle = .fullScreen
        
        //self.modalTransitionStyle = .partialCurl
        //nav.modalTransitionStyle = .partialCurl

        self.present(nav, animated: true, completion: nil)
        
        
    }
    

}

extension YDMainViewController{
    
    
    
    private func setupUI(){
        
        //获取tabbar配置
        let array = getConfigure()
        
        //把各控制器（View）加入主控制器中
        var arrayM = [UIViewController]()
        for dict in array {
            
            arrayM.append(initController(dict:dict))
        }
        viewControllers = arrayM
        //默认显示发现页
        selectedIndex = 2
    }
    
    //FIXME:通过文件（网络文件或本地文件）方式获取配置array
    private func getConfigure()->([[String:Any]]){
        var array:[[String:Any]] = [
            ["title":"书香门第"],
            ["title":"作品社区"],
            ["title":"发现"],
            ["title":"我的任务"],
            ["title":"个人中心"],
        ]
        for i in 0...4{
            array[i]["clsName"] = "YDt\(i+1)ViewController"
            array[i]["imgName"] = "t\(i+1)"
        }
        print(array)
        return array
    }
    
    
    //FIXME:通过字典 反射 生成类
    private func initController(dict:[String:Any])->(UIViewController){
        
        guard
            let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imgName = dict["imgName"] as? String,
            let cls = NSClassFromString("\(Bundle.main.infoDictionary?["CFBundleName"] ?? "").\(clsName)") as? BaseViewController.Type
            else {
                return UIViewController()
        }
//        let vc : UIViewController
//        if title == "我的任务"{
//            vc = YDt4ViewController(
//                titles: ["教师任务","完成任务","逾期任务"],
//                vcs: [TeacherTaskVC(),FinishedTaskVC(),OverdueTaskVC()],
//                segmentStyle: .navgationBarSegment)
////
//
//
//        }else{
//            vc = cls.init()
//        }
        let vc = cls.init()
        vc.title = title
        
        UITabBar.appearance().backgroundColor = UIColor.white
        
        //设置tabbar的标题颜色 和字体
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(hexString: "#23c993")], for: .highlighted)
        UITabBar.appearance().tintColor = UIColor(hexString: "23c993")
        //字体 默认为12 号
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 10)], for: [])
        //字往上移动
        vc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        //3. 设置图像
        
        vc.tabBarItem.image = UIImage(named: "\(imgName)")
        vc.tabBarItem.selectedImage = UIImage(named: "\(imgName)_hl")?.withRenderingMode(.alwaysOriginal)
        
        let nav = YDNavigationViewController(rootViewController: vc)
        return nav

    }
}
