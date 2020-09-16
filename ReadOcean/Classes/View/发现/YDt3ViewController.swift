//
//  YDt3ViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//



import UIKit
import SnapKit
import TLAnimationTabBar

public var tabbarHeight:CGFloat?

class YDt3ViewController : BaseViewController {
    
    private lazy var listViewModel = YDBooksListViewModel()
    
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
//            if galleryItems.count <= 0 { return }
//            let item = galleryItems[index]
//            if item.linkType == 3 {
//                guard let comicId = item.ext?.first?.val else {
//                    return
//                }
//
//                let storyboard = UIStoryboard(name: "ComicIntroVC", bundle: nil)
//                let cimicIntroVC = storyboard.instantiateViewController(withIdentifier: "ComicIntroVC") as! ComicIntroVC
//                cimicIntroVC.comicId = Int(comicId)
//                navigationController?.pushViewController(cimicIntroVC, animated: true)
//
//            } else {
//    //            guard let url = item.ext?.compactMap({
//    //                return $0.key == "url" ? $0.val : nil
//    //            }).joined() else {
//    //                return
//    //            }
//    //            let vc = WebViewController(url: url)
//    //            navigationController?.pushViewController(vc, animated: true)
//            }
        }
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        //layout.itemSize = CGSize(width: 100 , height: 50)
        //行列间距
        layout.minimumLineSpacing=10;
        layout.minimumInteritemSpacing=5
        
        //layout.footerReferenceSize = CGSize(width: screenWidth, height: 50)
        //layout.headerReferenceSize = CGSize(width: screenWidth, height: 50)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor(hexString: "ffffff")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: screenHeight/2, left: 0, bottom: 0, right: 0)
        //滚动条位置
        collectionView.scrollIndicatorInsets = collectionView.contentInset
        // 注册cell
        collectionView.register(cellType: YDBookCollectionViewCell.self)
        //collectionView.register(cellType: BoardCollectionViewCell.self)
        //注册头部 尾部
        collectionView.register(supplementaryViewType: YDBookCollectionHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(supplementaryViewType: YDBookCollectionFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
        // 刷新控件
        collectionView.myHead = URefreshHeader {
            
            self.loadData()
            
        }
        
        collectionView.myFoot = URefreshDiscoverFooter()
        //collectionView.myempty = UEmptyView(verticalOffset: -(collectionView.contentInset.top)) { self.setupLoadData() }
        
        return collectionView
    }()
    
    
    
    var value:CGFloat?{
        didSet{
            if let value = value{
                print("value didset")
            }
            
        }
    }
    
    

    @objc func loadData(){
        listViewModel.loadBooks { (isSuccess) in
            self.collectionView.myHead.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    override func setupLayout(){
        
        tabbarHeight = self.tabBarController?.tabBar.frame.height
        
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

extension YDt3ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    //背景颜色
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return UIColor.white
    }
    //边距？
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    //cell的视图
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: YDBookCollectionViewCell.self)
        if indexPath.item < listViewModel.booksList.count {
            cell.viewModel = listViewModel.booksList[indexPath.item]
        }
        
        return cell
    }
    //行数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //一个section里有几个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //返回9本书
        return listViewModel.booksList.count
    }
    //cell的长宽
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(Double(screenWidth - 60.0) / 3.0)
        return CGSize(width: width, height: width * 1.75)
    }
    // 头尾视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: YDBookCollectionHeaderView.self)

            
            return headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath, viewType: YDBookCollectionFooterView.self)
            return footerView
        }
    }

    // 头部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: screenWidth, height: 80)
        }
        return CGSize(width: screenWidth, height: 50)
    }

    // 尾部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 10)
    }
    
    //使头部视图滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navView.value = scrollView.contentOffset.y
        if scrollView.contentOffset.y >= -200 {
            self.style = .default

        } else {
            self.style = .lightContent
        }
        setNeedsStatusBarAppearanceUpdate()
        
        if scrollView == collectionView {
            bannerView.snp.updateConstraints{ $0.top.equalToSuperview().offset(min(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))) }
        }
    }
    
    
}

