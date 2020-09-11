//
//  HomeView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/9.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import SnapKit
import TLAnimationTabBar
class YDt1ViewController : BaseViewController {
    
    private lazy var listViewModel = YDBooksListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    private lazy var navView : HomeNavView = {
        let nav = HomeNavView()
        nav.searchBtnClickClosure {
            print("搜索click")
            let vc = YDDemoViewController()
            vc.view.backgroundColor = UIColor.orange
            vc.hidesBottomBarWhenPushed = true
            
            //self.navigationController?.hidesBarsOnSwipe = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return nav
    }()
    
    private lazy var headerView:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.addSubview(background_img)
        background_img.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
        
        v.addSubview(rect)
        rect.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalTo(v.snp.centerX)
            make.width.equalTo(screenWidth-30)
            make.height.equalTo(64)
        }
        return v
        
    }()
    
    private lazy var background_img:UIImageView = {
        let v = UIImageView(image: UIImage(named: "background"))
        return v
    }()
    
    private lazy var img_avatar:UIImageView = {
        var img = UIImage(named: "img_boy")
        img = img?.reSizeImage(reSize: CGSize(width: 50, height: 50))
        
        let imgView = UIImageView(image: img)
        imgView.backgroundColor = UIColor(hexString: "f2f2f2")
        
        imgView.layer.cornerRadius = imgView.bounds.width/2
        imgView.layer.borderColor = UIColor.clear.cgColor
        imgView.layer.borderWidth = 0.5
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    private lazy var loginLabel : UILabel = {
       let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 15))
        txt.text = "登陆后发现精彩内容,阅读最新书籍，成为读书之星"
        txt.font = .systemFont(ofSize: 10)
        txt.textColor = UIColor.darkGray
        txt.textAlignment = .left
        txt.numberOfLines = 0
        return txt
    }()
    
    private lazy var loginBtn : UIButton = {
       let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 15))
        btn.setTitle("立即登陆", for: [])
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor(hexString: "5ad3b3")
        return btn
    }()
    
    private lazy var rect:UIView = {
       let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 5
        v.layer.borderColor = UIColor.clear.cgColor
        v.layer.borderWidth = 0.5
        
        v.layer.shadowColor = UIColor.darkGray.cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 5)
        v.layer.shadowOpacity = 0.4
        v.layer.shadowRadius = 5
        
        v.addSubview(img_avatar)
        img_avatar.snp.makeConstraints { (make) in

            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        v.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(v.snp.centerY).offset(-5)
            make.left.equalTo(img_avatar.snp.right).offset(10)
        }
        
        v.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginLabel.snp.bottom).offset(10)
            make.left.equalTo(loginLabel.snp.left)
            make.height.equalTo(20)
            make.width.equalTo(70)
        }
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
        collectionView.contentInset = UIEdgeInsets(top: screenHeight/4.0 - 30, left: 0, bottom: 0, right: 0)
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
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(tabbarHeight ?? 0))
        }
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(screenHeight/4)
        }
        
        
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(88)
        }
    }
}

extension YDt1ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
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
        print("contentoffset.y = \(scrollView.contentOffset.y)")
        print("contentInset.top = \(scrollView.contentInset.top)")
        print("和 = \(scrollView.contentOffset.y + scrollView.contentInset.top)\n")
        //setNeedsStatusBarAppearanceUpdate()
        
        if scrollView == collectionView {
            headerView.snp.updateConstraints{ $0.top.equalToSuperview().offset(min(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))) }
        }
    }
    
    
}
