//
//  TaskVC.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/7.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDt4ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
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
        config.isShowBottomLine = true
        
        return config
    }()
    
    private lazy var titleView : GXSegmentTitleView = {
        let v = GXSegmentTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64), config: config, titles: ["教师任务","完成任务","逾期任务"])
        v.delegate = self
        return v
    }()
    
    private lazy var pageView: GXSegmentPageView = {
        let v = GXSegmentPageView(parent: self, children: [TeacherTaskVC(),FinishedTaskVC(),OverdueTaskVC()])
        v.delegate = self
        return v
    }()
    
    override func configNavigationBar() {
        super.configNavigationBar()
        
        
    }
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(pageView)
        pageView.snp.makeConstraints { (make) in
            
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-tabbarHeight!)
        }
        view.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(88)
        }
    }
    
    

}
extension YDt4ViewController: GXSegmentPageViewDelegate {
    func segmentPageView(_ segmentPageView: GXSegmentPageView, at index: Int) {
        NSLog("index = %d", index)
    }
    func segmentPageView(_ page: GXSegmentPageView, progress: CGFloat) {
        self.titleView.setSegmentTitleView(selectIndex: page.selectIndex, willSelectIndex: page.willSelectIndex, progress: progress)
    }
}

extension YDt4ViewController: GXSegmentTitleViewDelegate {
    func segmentTitleView(_ page: GXSegmentTitleView, at index: Int) {
        self.pageView.scrollToItem(to: index, animated: true)
    }
}

