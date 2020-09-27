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

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        //layout.itemSize = CGSize(width: 100 , height: 50)
        //行列间距
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 15
        
        //layout.footerReferenceSize = CGSize(width: screenWidth, height: 50)
        //layout.headerReferenceSize = CGSize(width: screenWidth, height: 50)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: screenHeight/2.0, left: 0, bottom: 0, right: 0)
        //滚动条位置
        collectionView.scrollIndicatorInsets = collectionView.contentInset
        // 注册cell
        collectionView.register(cellType: YDBookCollectionViewCell.self)
        collectionView.register(cellType: DiscoverBooksHeaderTableView.self)
        //注册头部 尾部
        collectionView.register(supplementaryViewType: BookCollectionHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        //collectionView.register(supplementaryViewType: DiscoverBooksHeaderTableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(supplementaryViewType: YDBookCollectionFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
        
        // 刷新控件
        collectionView.myHead = URefreshHeader {[weak self] in self?.loadData()}
        let footView = MJRefreshAutoFooter(refreshingBlock: {[weak self] in
            self?.loadData()
        })

        collectionView.mj_footer = footView
        
        return collectionView
    }()
    
    
    private func didSelectBanner(index: Int) {
            print("轮播图被点击了...")

    }
    
    @objc func loadData(){
        
        
    }
    
    override func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-tabbarHeight!)
        }
        
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints{ make in

            make.top.left.right.equalToSuperview()
            make.height.equalTo(collectionView.contentInset.top)
        }
         
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(120)
        }
    }
}


extension YDt3ViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    //行数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DiscoverBooksHeaderTableView.self)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: YDBookCollectionViewCell.self)
        return cell
    }
    //Cell长宽
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: screenWidth, height: 330)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: BookCollectionHeaderView.self)
            headerView.backgroundColor = UIColor.white
            headerView.titleLabel.text = "书香门第"
            return headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath, viewType: YDBookCollectionFooterView.self)
            footerView.backgroundColor = UIColor.white
            return footerView
        }
    }
    //头部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var size = CGSize.zero
        switch section {
        case 0:
            size = CGSize(width: screenWidth, height: 50)
        default:
            break
        }
        return size
    }
    //尾部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 10)
    }
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("\(scrollView)")
        print("contentoffset.y = \(scrollView.contentOffset.y)")
        print("contentInset.top = \(scrollView.contentInset.top)")
        print("contentSize = \(scrollView.contentSize)")
        print("和 = \(scrollView.contentOffset.y + scrollView.contentInset.top)\n")
        
 
        if scrollView == self.collectionView {
            
            
            if scrollView.contentOffset.y >= -200 {
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
