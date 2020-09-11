//
//  YDMainViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import TLAnimationTabBar



class YDMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
