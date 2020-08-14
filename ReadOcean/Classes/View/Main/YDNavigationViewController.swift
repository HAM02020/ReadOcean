//
//  YDNavigationViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/24.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDNavigationViewController: UINavigationController {

    fileprivate lazy var customNavigationBar: CustomNavigationBar = {

            let bar = CustomNavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 64))

            bar.tintColor = UIColor.white
            bar.tintAdjustmentMode = .normal
            bar.alpha = 0
            bar.setItems([UINavigationItem(title: "书香门第")], animated: false)

            bar.backgroundColor = UIColor.clear
            bar.barStyle = .black
            bar.isTranslucent = true
            bar.shadowImage = UIImage()
            bar.setBackgroundImage(UIImage(named: "ocean"), for: UIBarMetrics.default)

       
            bar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
            ]

            return bar
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //view.addSubview(customNavigationBar)
        //修复安全区
        //edgesForExtendedLayout.
        //self.additionalSafeAreaInsets.top = customNavigationBar.frame.size.height
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        //self.setNavigationBarHidden(true, animated: false)
        
        
        customNavigationBar.alpha = 1.0
        //customNavigationBar.frame.size = customNavigationBar.sizeThatFits(CGSize(width: customNavigationBar.frame.size.width, height: 84))
    }
    
    private func setupUI(){
        
//        navigationItem.setRightBarButtonItems([
//        UIBarButtonItem(title: "按钮1", style: .plain, target: self, action: #selector(btn_click)),
//        UIBarButtonItem(title: "按钮2", style: .plain, target: self, action: #selector(btn_click))
//        ], animated: false)
        //定制右按钮

//        let but = WBTittleButton(title: "书香弟弟")
//        let but_item = UIBarButtonItem(customView: but)
//        navigationItem.titleView = but
            

    }
    
    @objc private func btn_click(){
        
    }
}
