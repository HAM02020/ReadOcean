//
//  BooksCategorysMainVC.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/9/28.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BooksCategorysMainVC:BaseViewController{

    private var categoryParam = ""
    
    private let categoriesParams = ["category_shige","category_kexue","category_manhua","category_tonghua","category_shenhua","category_lishi","category_shuxue","category_xiaoshuo","category_mingzhu","category_mingren"]
    
    convenience init(_ categoryParam: String){
        self.init()
        self.categoryParam = categoryParam
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "分类"
        pageView.scrollToItem(to: categoriesParams.firstIndex(of: categoryParam) ?? 0, animated: false)
        titleView.setSelectIndex(at: categoriesParams.firstIndex(of: categoryParam) ?? 0, animated: false)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
//    private lazy var navView:CommunityNavView={
//       let nav = CommunityNavView()
//        nav.backgroundColor = UIColor.clear
//       return nav
//    }()
    
    private let config : GXSegmentTitleView.Configuration = {
        let config = GXSegmentTitleView.Configuration()
        config.positionStyle = .bottom
        config.indicatorStyle = .dynamic
        config.indicatorFixedWidth = 20
        config.indicatorFixedHeight = 2.0
        //config.indicatorAdditionWidthMargin = 5.0
        //config.indicatorAdditionHeightMargin = 2.0
        
        config.isShowSeparator = true
        config.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        config.titleSelectedColor = UIColor(hexString: "23c993")
        config.titleNormalColor = UIColor.darkGray
        config.separatorColor = UIColor(hexString: "e6e6e6")
        config.indicatorColor = UIColor(hexString: "23c993")
        config.isShowBottomLine = false
        
        
        return config
    }()
    
    private lazy var titleView : GXSegmentTitleView = {
        let v = GXSegmentTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40), config: config, titles: ["优美诗歌","自然","绘本","童话故事","神话传奇","文史","数学","小说散文","世界名著","名人传记"])
        v.delegate = self
        //v.backgroundColor = UIColor.init(patternImage: UIImage(named: "f5tof2") ?? UIImage())
        v.backgroundColor = UIColor.white
        return v
    }()
    
    private lazy var pageView: GXSegmentPageView = {
        var vcs:[BookCategorysVC] = []
        for category in categoriesParams{
            vcs.append(BookCategorysVC(category))
        }
        let v = GXSegmentPageView(parent: self, children: vcs)
        v.delegate = self
        
        return v
    }()
    
    override func configNavigationBar() {
        super.configNavigationBar()
        
        
    }
    override func setupLayout() {
        super.setupLayout()
        let background = UIImageView(image: UIImage(named: "fatof2"))
        view.addSubview(background)
        background.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        
        view.addSubview(pageView)
        pageView.snp.makeConstraints { (make) in
            print("navHeight = \(navHeight)  statusBarHeight = \(statusBarHeight)")
            make.top.equalToSuperview().offset(navHeight + statusBarHeight + 40)
            make.left.right.bottom.equalToSuperview()

        }
        view.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(navigationNormalHeight + statusBarHeight)
            make.height.equalTo(40)
        }
    }
    
    

}
extension BooksCategorysMainVC: GXSegmentPageViewDelegate {
    func segmentPageView(_ segmentPageView: GXSegmentPageView, at index: Int) {
        NSLog("index = %d", index)
    }
    func segmentPageView(_ page: GXSegmentPageView, progress: CGFloat) {
        self.titleView.setSegmentTitleView(selectIndex: page.selectIndex, willSelectIndex: page.willSelectIndex, progress: progress)
    }
}

extension BooksCategorysMainVC: GXSegmentTitleViewDelegate {
    func segmentTitleView(_ page: GXSegmentTitleView, at index: Int) {
        self.pageView.scrollToItem(to: index, animated: true)
    }
}

