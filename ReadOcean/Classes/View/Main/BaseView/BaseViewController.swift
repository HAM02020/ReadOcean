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
}

extension BaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
}

