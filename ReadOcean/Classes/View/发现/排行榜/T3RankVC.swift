//
//  T3RankVC.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/11/10.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class T3RankVC: BaseViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let l = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        l.backgroundColor = UIColor.black
        navigationItem.titleView = titleView
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        //navigationController?.navigationBar.isHidden = true
        //navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    private let config : GXSegmentTitleView.Configuration = {
        let config = GXSegmentTitleView.Configuration()
        config.positionStyle = .bottom
        config.indicatorStyle = .dynamic
        config.indicatorFixedWidth = 60.0
        config.indicatorFixedHeight = 2.0
        config.indicatorAdditionWidthMargin = 5.0
        config.indicatorAdditionHeightMargin = 2.0
        config.isShowSeparator = false
        config.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        config.titleSelectedColor = UIColor(hexString: "23c993")
        config.separatorColor = UIColor(hexString: "23c993")
        config.indicatorColor = UIColor(hexString: "23c993")
        config.isShowBottomLine = false
        
        return config
    }()
    
    private lazy var titleView: GXSegmentTitleView = {
        let v = GXSegmentTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth/2, height: 44), config: config, titles: ["积分榜","书香榜"])
        v.delegate = self
        return v
    }()
    private lazy var menuView: T3MenuView = {
        let v = T3MenuView(numOfItems: 3, names: ["班排名","校排名","区排名"]);
        v.delegate = self
        return v
    }()
    
    
    lazy var pageView: GXSegmentPageView = {
        let v = GXSegmentPageView(parent: self, children: [TeacherTaskVC(),FinishedTaskVC()])
        v.frame = CGRect.zero
        v.delegate = self
        return v
    }()
    
    override func configNavigationBar() {
        super.configNavigationBar()
        
        
    }
    override func setupLayout() {
        super.setupLayout()
        //navigationController?.navigationItem.titleView = titleView
        
        view.addSubview(pageView)
        pageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-statusBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        view.addSubview(menuView)
        menuView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(statusBarHeight + navigationNormalHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    
    

}

extension T3RankVC: T3MenuViewDelegate{
    func menuView(buttonDidClick title: String) {
        switch title {
        case "校排名":
            print("校排名")
        default:
            break
        }
    }
    
    
}


extension T3RankVC: GXSegmentPageViewDelegate {
    func segmentPageView(_ segmentPageView: GXSegmentPageView, at index: Int) {
        NSLog("index = %d", index)
    }
    func segmentPageView(_ page: GXSegmentPageView, progress: CGFloat) {
        self.titleView.setSegmentTitleView(selectIndex: page.selectIndex, willSelectIndex: page.willSelectIndex, progress: progress)
    }
}

extension T3RankVC: GXSegmentTitleViewDelegate {
    func segmentTitleView(_ page: GXSegmentTitleView, at index: Int) {
        self.pageView.scrollToItem(to: index, animated: true)
    }
}
