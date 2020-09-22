//
//  YDt3ViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//



import UIKit
import SnapKit


public var tabbarHeight:CGFloat?

class YDt3ViewController : BaseViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    var style: UIStatusBarStyle = .lightContent
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return self.style
    }
    private lazy var navView : DiscoverNavView = {
        let nav = DiscoverNavView()
        
        return nav
    }()

    private lazy var bannerView: LLCycleScrollView = {
        let cycleScrollView = LLCycleScrollView()
        cycleScrollView.backgroundColor = UIColor.systemBackground
        cycleScrollView.autoScrollTimeInterval = 6
        cycleScrollView.placeHolderImage = UIImage(named: "normal_placeholder_h")
        cycleScrollView.coverImage = UIImage(named: "normal_placeholder_h")
        cycleScrollView.pageControlBottom = 20
        cycleScrollView.titleBackgroundColor = UIColor.clear
        cycleScrollView.customPageControlStyle = .image
        cycleScrollView.pageControlPosition = .left
//        cycleScrollView.pageControlActiveImage = UIImage(named: "emojiCommunity")
        cycleScrollView.pageControlInActiveImage = UIImage(named: "pagecontrol")

        // 点击 item 回调
        cycleScrollView.lldidSelectItemAtIndex = didSelectBanner(index:)
        var bannerpics:[String] = []
        var bgPics:[String] = []
        for i in 1...3{
            bannerpics.append("b\(i)")
            bgPics.append("normal_placeholder_h")
        }
        cycleScrollView.bg_imagePaths = bannerpics
        cycleScrollView.imagePaths = bgPics
    
        
    
        return cycleScrollView
        }()
    
    private func didSelectBanner(index: NSInteger) {
            print("轮播图被点击了...")

        }
    
    private lazy var booksTableView = BooksTableView(frame: CGRect.zero)
    
    private lazy var contentView:UIView = {
        let contentView = UIView()
        //contentView.backgroundColor = UIColor(hexString: "f2f2f2")
        
        
        contentView.addSubview(booksTableView)
        booksTableView.snp.makeConstraints { (make) in
            //transform之前宽高对调
            let height:CGFloat = 300
            make.height.equalTo(screenWidth)
            make.width.equalTo(height)
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(screenHeight/2+height/2)
        }
        booksTableView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        
        
        return contentView
    }()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        //scrollView.contentInset = UIEdgeInsets(top: screenHeight/2, left: 0, bottom: 0, right: 0)
        //滚动条位置
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(screenHeight*2)
        }
        
        
        
        return scrollView
    }()
    
    

    
    

    @objc func loadData(){
//        listViewModel.loadBooks { (isSuccess) in
//            self.collectionView.myHead.endRefreshing()
//            self.collectionView.reloadData()
//        }
    }
    
    override func setupLayout(){
        
        tabbarHeight = self.tabBarController?.tabBar.frame.height
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-tabbarHeight!)
        }
        
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints{ make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(screenHeight/2)
        }
         
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(120)
        }
    }
}

extension YDt3ViewController:UIScrollViewDelegate{
    
    //使头部视图滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navView.value = scrollView.contentOffset.y
        print("contentoffset.y = \(scrollView.contentOffset.y)")
        print("contentInset.top = \(scrollView.contentInset.top)")
        print("contentSize = \(scrollView.contentSize)")
        print("和 = \(scrollView.contentOffset.y + scrollView.contentInset.top)\n")
        if scrollView.contentOffset.y >= -200 {
            self.style = .default

        } else {
            self.style = .lightContent
        }
        setNeedsStatusBarAppearanceUpdate()
        
        if scrollView == self.scrollView {
            bannerView.snp.updateConstraints{ $0.top.equalToSuperview().offset(min(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))) }
        }
    }
    
    
}

