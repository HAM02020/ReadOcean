//
//  YDt2ViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDt2ViewController: BaseViewController {

    private lazy var listViewModel=[String:[Block]]()
    private let categories = ["全部板块","优美诗歌","绘本","自然","童话故事","神话传奇","文史","数学","小说散文","世界名著","名人传记"]
    private let categoriesParams = ["","category_shige","category_kexue","category_manhua","category_tonghua","category_shenhua","category_lishi","category_shuxue","category_xiaoshuo","category_mingzhu","category_mingren"]
    private let maxCellNum = 4
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    private lazy var navView:CommunityNavView={
       let nav = CommunityNavView()
       return nav
    }()
    private lazy var background:UIView={
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 20
        //设置上面两个角为圆角
        v.layer.maskedCorners = CACornerMask(rawValue: CACornerMask.layerMinXMinYCorner.rawValue | CACornerMask.layerMaxXMinYCorner.rawValue)
        return v
    
    }()
    private lazy var backgroundImg:UIImageView={
        let iv = UIImageView(image: UIImage(named: "zpsq_background"))
        iv.alpha = 0.8
        return iv
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        //layout.itemSize = CGSize(width: 100 , height: 50)
        //行列间距
        layout.minimumLineSpacing=10;
        layout.minimumInteritemSpacing=1
        
        //layout.footerReferenceSize = CGSize(width: screenWidth, height: 50)
        //layout.headerReferenceSize = CGSize(width: screenWidth, height: 50)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: screenHeight/5, left: 0, bottom: 0, right: 0)
        
        //滚动条位置
        collectionView.scrollIndicatorInsets = collectionView.contentInset
        // 注册cell
        collectionView.register(cellType: BlockCollectionViewCell.self)
        //collectionView.register(cellType: BoardCollectionViewCell.self)
        //注册头部 尾部
        //collectionView.register(supplementaryViewType: CornerTopHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(supplementaryViewType: BlockCollectionHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(supplementaryViewType: YDBookCollectionFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
        // 刷新控件
        collectionView.myHead = URefreshHeader {
            
            //self.loadData()
            
        }
        
        collectionView.myFoot = URefreshDiscoverFooter()
        //collectionView.myempty = UEmptyView(verticalOffset: -(collectionView.contentInset.top)) { self.setupLoadData() }
        
        return collectionView
    }()

    override func setupLayout() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            guard let tabbarHeight = self.tabBarController?.tabBar.frame.height else{return}
            make.bottom.equalToSuperview().offset(-tabbarHeight)
        }
        
        view.addSubview(backgroundImg)
        backgroundImg.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(collectionView.contentInset.top)
        }
        view.addSubview(background)
        background.snp.makeConstraints { (make) in
            make.bottom.equalTo(backgroundImg.snp.bottom)
            make.width.equalTo(screenWidth)
            make.height.equalTo(30)
        }
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(88)
        }
    }
}
extension YDt2ViewController{
    private func loadData(){
        //调度组
        let group = DispatchGroup()
        
        let url = hostAddress + "/mobileForum/getBlocks"
        
        
        for category in categoriesParams{
            //入组
            group.enter()
            
            let param = ["category":category] as [String : AnyObject]
            
            YDNetworkManager.shared.request(URLString: url, parameters: param) { (json, isSuccess) in
                if !isSuccess{
                    return
                }
                guard
                    let json = json as? [String:Any],
                    let result = ReturnWithDataList<Block>.deserialize(from: json),
                    let blockList = result.dataList
                    else { return }
                
                self.listViewModel[category] = blockList
                //self.listViewModel.append(blockList)
                //出组
                group.leave()
            }
            
        }
        // 监听调度组情况
        group.notify(queue: DispatchQueue.main) {
            self.collectionView.myHead.endRefreshing()
            self.collectionView.reloadData()
        }
        
        
        
        
    }
}
extension YDt2ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
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
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: BlockCollectionViewCell.self)
        //cell.viewModel = categoriesParams[indexPath.section]//[indexPath.item]
        if indexPath.item >= maxCellNum{
            return UICollectionViewCell()
        }
        
        let key = categoriesParams[indexPath.section]
        cell.viewModel = listViewModel[key]![indexPath.item]
        
        return cell
    }
    //行数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //let rows = Double(listViewModel?.booksList.count ?? 1) / 3.0
        return listViewModel.count
    }
    //一个section里有几个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = categoriesParams[section]
        guard let count = listViewModel[key]?.count else {
            return 4
        }
        return count < maxCellNum ? count : maxCellNum
    }
    //cell的长宽
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(Double(screenWidth - 30.0) / 2.0)
        return CGSize(width: width, height: width * 0.85)
    }
    // 头尾视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: BlockCollectionHeaderView.self)
            if indexPath.section == 0{
                headerView.layer.cornerRadius = headerView.bounds.width/15
            }
            headerView.iconView.image = UIImage(named: "hot")
            headerView.titleLabel.text = categories[indexPath.section]
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
        if scrollView == collectionView {
            backgroundImg.snp.updateConstraints{ $0.top.equalToSuperview().offset(min(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))) }
        }
    }
}
