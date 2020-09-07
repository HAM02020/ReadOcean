
//
//  YDt4ViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDt4ViewController: SegmentMainController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    override func configNavigationBar() {
        super.configNavigationBar()
        
        
    }
    override func setupLayout() {
        super.setupLayout()
        segment.backgroundColor = UIColor(hexString: "0ae6b0")

        let v = UIView()
        v.backgroundColor = UIColor(hexString: "0ae6b0")
        view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(segment.snp.top)
            make.left.right.equalToSuperview()
        }
    }
    
    

}
