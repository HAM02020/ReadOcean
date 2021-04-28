//
//  YDOceanWorldViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/16.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit
import WebKit
class YDOceanWorldViewController: BaseViewController{
    
    var userId:String{
        get{
            return UserAccount.shardAccount.userId
        }
    }
    
    lazy var url = URL(string: "https://ro.bnuz.edu.cn/ocean/index?userId=\(userId)")
    
    private lazy var webView: WKWebView = {
        let v = WKWebView()
        v.allowsBackForwardNavigationGestures = true
        v.autoresizesSubviews = true
        v.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        v.scrollView.isScrollEnabled = false

        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = url else {navigationController?.popViewController(animated: true); return}
        let req = URLRequest(url: url)
        
        webView.load(req)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func setupLayout() {
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(navHeight + statusBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
