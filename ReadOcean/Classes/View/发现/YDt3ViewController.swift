//
//  YDt3ViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/25.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import MJRefresh

class YDt3ViewController : BaseViewController{
    
    var blocksListViewModel = BlocksListViewModel()
    
    private var bannerpics:[String] = ["b1","b2","b3"]
    
    var style: UIStatusBarStyle = .lightContent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
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
        cycleScrollView.customPageControlStyle = .system

        cycleScrollView.pageControlPosition = .right
//        cycleScrollView.pageControlActiveImage = UIImage(named: "emojiCommunity")
        //cycleScrollView.pageControlInActiveImage = UIImage(named: "pagecontrol")

        // 点击 item 回调
        cycleScrollView.lldidSelectItemAtIndex = didSelectBanner(index:)
        


        cycleScrollView.bg_imagePaths = bannerpics
        cycleScrollView.imagePaths = bannerpics



        return cycleScrollView
    }()

    lazy var tableView : UITableView = {
        let t = UITableView()
        //设置代理
        t.contentInset = UIEdgeInsets(top: screenHeight/2, left: 0, bottom: 0, right: 0)
        t.dataSource = self
        t.delegate = self
        //注册cell
        t.register(cellType: BlockTableViewCell.self)
        //去除分割线
        t.separatorStyle = .none
        //MARK:解决reloadData上拉 闪动的问题
        t.estimatedRowHeight = 180
        t.estimatedSectionHeaderHeight = 0
        t.estimatedSectionFooterHeight = 0
        
        
        // 刷新控件
        t.myHead = URefreshHeader {[weak self] in self?.loadData()}
        let footView = MJRefreshAutoFooter(refreshingBlock: {[weak self] in
            self?.loadData()
        })

        t.mj_footer = footView
        
        
        //t.myFoot = URefreshDiscoverFooter()
        //下拉刷新
        //t.refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        return t
    }()
    
    private lazy var bookHorizonTableView : DiscoverBooksTableView = {
        let t = DiscoverBooksTableView(frame: CGRect.zero)
        return t
    }()
    
    private func didSelectBanner(index: Int) {
            print("轮播图被点击了...")

    }
    
    @objc func loadData(){
        if !listViewModel.dataDict.isEmpty{
            return
        }
        
        ProgressHUD.show()
        
        listViewModel.getBooks {[weak self] in
            self?.bookHorizonTableView.reloadData()
            ProgressHUD.showSucceed()
        }
        
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-tabbarHeight!)
        }
        
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints{ make in

            make.top.left.right.equalToSuperview()
            make.height.equalTo(tableView.contentInset.top)
        }
         
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(120)
        }
    }
}


extension YDt3ViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }

    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("\(scrollView)")
        print("contentoffset.y = \(scrollView.contentOffset.y)")
        print("contentInset.top = \(scrollView.contentInset.top)")
        print("contentSize = \(scrollView.contentSize)")
        print("和 = \(scrollView.contentOffset.y + scrollView.contentInset.top)\n")
        
 
        if scrollView == self.tableView {
            
            
            if scrollView.contentOffset.y >= 200 {
                self.style = .darkContent
            } else {
                self.style = .lightContent
            }
            
            setNeedsStatusBarAppearanceUpdate()
            
            navView.value = scrollView.contentOffset.y
            
            bannerView.snp.updateConstraints{ $0.top.equalToSuperview().offset(min(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))) }
 
        }

    }
    
}
