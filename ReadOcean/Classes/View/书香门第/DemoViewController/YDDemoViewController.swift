//
//  YDDemoViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/16.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import HandyJSON

class YDDemoViewController: BaseViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置标题
        title = "第\(navigationController?.viewControllers.count ?? 0)个"
        view.backgroundColor = UIColor.white

        navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(named: "blue"),style: .plain,target: self,action: #selector(showNext))
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @objc private func showNext() {
        let vc = YDDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
