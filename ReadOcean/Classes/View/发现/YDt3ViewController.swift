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

let DiscoverTableViewCellType = "DiscoverTableViewCellType"

class YDt3ViewController : BaseViewController {
    
    private lazy var listViewModel = BooksListViewModel()
    private var bannerpics:[String] = ["b1","b2","b3"]

    

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

    
    private func didSelectBanner(index: Int) {
            print("轮播图被点击了...")

    }
    private func didScrollBanner(currentIndex: Int) {
            print("轮播图滚动了...")

    }
    
    private lazy var tableView : UITableView = {
        let t = UITableView()
        t.automaticallyAdjustsScrollIndicatorInsets = false
        t.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        t.delegate = self
        t.dataSource = self
        //transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        t.backgroundColor = UIColor.yellow
        t.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        t.separatorStyle = .none
        
        //优化
        t.rowHeight = 320
        t.estimatedRowHeight = 320
        
        
        
        t.register(UINib(nibName: "DiscoverBooksTableViewCell", bundle: nil), forCellReuseIdentifier: DiscoverTableViewCellType)
        return t
    }()
    
    @objc func loadData(){
        
        ProgressHUD.show()

        listViewModel.getBooks {[weak self] in
            self?.tableView.reloadData()
            ProgressHUD.showSucceed()
        }
        
    }
    
    private lazy var titleLabel1:UILabel = {
        let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        txt.text = "书香门第"
        txt.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        txt.textColor = UIColor.black
        txt.numberOfLines = 1
        return txt
    }()
    
    private lazy var contentView:UIView = {
        let contentView = UIView()
        //contentView.backgroundColor = UIColor(hexString: "f2f2f2")
        
        contentView.addSubview(titleLabel1)
        titleLabel1.snp.makeConstraints { (make) in
            make.top.equalTo(screenHeight/2+10)
            make.left.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        contentView.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            //transform之前宽高对调
            let height:CGFloat = 330
            make.height.equalTo(screenWidth)
            make.width.equalTo(height)
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(screenHeight/2+height/2+titleLabel1.bounds.height)
            //make.top.equalTo(titleLabel1.snp.bottom)
        }
        tableView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        
        
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

extension YDt3ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.dataDict.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverTableViewCellType, for: indexPath) as! DiscoverBookTableViewCell
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let key = listViewModel.categoriesParams[indexPath.row]
        let cell = (cell as! DiscoverBookTableViewCell)
        cell.listViewModel = listViewModel.dataDict[key]!
        
    }
    
    //使头部视图滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("contentoffset.y = \(scrollView.contentOffset.y)")
        print("contentInset.top = \(scrollView.contentInset.top)")
        print("contentSize = \(scrollView.contentSize)")
        print("和 = \(scrollView.contentOffset.y + scrollView.contentInset.top)\n")
        
        
        
        if scrollView == self.scrollView {
            
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


