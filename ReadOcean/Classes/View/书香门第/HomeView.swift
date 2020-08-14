//
//  HomeView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/9.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit


class HomeView: UIView {

    //使用nib
//    class func homeView() -> HomeView{
//        let nib = UINib(nibName: "HomeView", bundle: nil)
//        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! HomeView
//        return v
//    }
    private lazy var navView : HomeNavView = {
        let nav = HomeNavView()
        return nav
    }()
    
    private lazy var v1:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
//        v.layer.backgroundColor = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
//        v.layer.shadowColor = UIColor.init(red: 135/255.0, green: 142/255.0, blue: 154/255.0, alpha: 0.3).cgColor
//        v.layer.shadowOffset = CGSize(width: 0, height: 2)
//        v.layer.shadowOpacity = 1
//        v.layer.shadowRadius = 2
//        v.layer.cornerRadius = 6
//        v.layer.borderWidth = 1.0
//        v.layer.borderColor = UIColor.darkGray.cgColor
        
        return v
        
    }()
    private lazy var background_img:UIImageView = {
        let v = UIImageView(image: UIImage(named: "background"))
        return v
    }()
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
        collectionView.contentInset = UIEdgeInsets(top: screenHeight/3.0, left: 0, bottom: 0, right: 0)
        //滚动条位置
        collectionView.scrollIndicatorInsets = collectionView.contentInset
        // 注册cell
        collectionView.register(cellType: YDBookCollectionViewCell.self)
        //collectionView.register(cellType: BoardCollectionViewCell.self)
        //注册头部 尾部
        collectionView.register(supplementaryViewType: YDBookCollectionHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(supplementaryViewType: YDBookCollectionFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
        // 刷新控件
        //collectionView.uHead = URefreshHeader { [weak self] in self?.setupLoadData() }
        //collectionView.uFoot = URefreshDiscoverFooter()
        //collectionView.uempty = UEmptyView(verticalOffset: -(collectionView.contentInset.top)) { self.setupLoadData() }
        
        return collectionView
    }()
    var listViewModel:YDBooksListViewModel?{
        didSet{
            loadData()
        }
    }
    var value:CGFloat?{
        didSet{
            if let value = value{
                print("value didset")
            }
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func loadData(){
        listViewModel?.loadBooks { (isSuccess) in
            self.collectionView.reloadData()
        }
    }
    
    func setupLayout(){
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        addSubview(v1)
        v1.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(collectionView.contentInset.top)
        }
        v1.addSubview(background_img)
        background_img.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(88)
        }
    }
}

extension HomeView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
        if indexPath.item < listViewModel?.booksList.count ?? 0{
            cell.viewModel = listViewModel?.booksList[indexPath.item]
        }
        
        return cell
    }
    //行数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //let rows = Double(listViewModel?.booksList.count ?? 1) / 3.0
        return 1
    }
    //一个section里有几个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //返回9本书
        return (listViewModel?.booksList.count ?? 1 ) - 1 
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
        return CGSize(width: screenWidth, height: 50)
    }

    // 尾部高度
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return modules.count - 1 != section ? CGSize(width: screenWidth, height: 10) : CGSize.zero
//    }
    //使头部视图滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navView.value = scrollView.contentOffset.y
        print("contentoffset.y = \(scrollView.contentOffset.y)")
        print("contentInset.top = \(scrollView.contentInset.top)")
        print("和 = \(scrollView.contentOffset.y + scrollView.contentInset.top)\n")
        //setNeedsStatusBarAppearanceUpdate()
        
        if scrollView == collectionView {
            v1.snp.updateConstraints{ $0.top.equalToSuperview().offset(min(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))) }
        }
        }
    
    
}
