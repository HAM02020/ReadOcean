//
//  CategoryVC.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/10.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import MJRefresh



class CategoryVC : BaseViewController {

    var listViewModel = BlocksListViewModel()
    
    var loadingView = LPH.getPlaceHolderView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(hexString: "f2f2f2")
        loadData(isFirstLoad:true,isPullup: true)
    }

    
    class func build(_ category:String)->CategoryVC{
        let vc = CategoryVC()
        vc.listViewModel.category = category
        return vc
    }

    lazy var tableView : UITableView = {
        let t = UITableView()
        t.backgroundColor = UIColor.clear
        //设置代理
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
        t.myHead = URefreshHeader {[weak self] in self?.loadData(isPullup: false)}
        
        t.gx_footer = GXRefreshNormalFooter{ [weak self] in
            self?.loadData(isPullup: true)
        }

        return t
    }()
    override func setupLayout() {
        
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
    var refreshCount = 0
    
    @objc func loadData(isFirstLoad:Bool=false,isPullup:Bool){
        

        if isFirstLoad{
            loadingView.cover(self.view,animated: false)
        }else{
            //ProgressHUD.show()
        }
        listViewModel.loadData(isFirstLoad: isFirstLoad, isPullup: isPullup) {[weak self] (noMoreData) in
            self?.tableView.reloadData()
            self?.tableView.myHead.endRefreshing()
            self?.tableView.gx_footer?.endRefreshing(isNoMore: noMoreData)
            self?.loadingView.uncover()
            
        }
        
    }
}
extension CategoryVC : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.myBlockList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BlockTableViewCell.self)
        cell.viewModel = listViewModel.myBlockList[indexPath.row]
        
        return cell
    }
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let blockDetailVC = YDBlocksDetailViewController()
        blockDetailVC.blockId = listViewModel.myBlockList[indexPath.row].blockId
        blockDetailVC.myBlock = listViewModel.myBlockList[indexPath.row]
        blockDetailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(blockDetailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

//        print("contentoffset.y = \(scrollView.contentOffset.y)")
//        print("bounds.height = \(scrollView.bounds.height)")
//        print("contentSize.height = \(scrollView.contentSize.height)")
//        
//        print("contentInset.top = \(scrollView.contentInset.top)")
//        print("和 = \(scrollView.contentOffset.y + scrollView.contentInset.top)\n")
        //setNeedsStatusBarAppearanceUpdate()
        
        if scrollView == tableView {
            //滑动到底部
//            if(scrollView.contentOffset.y+scrollView.bounds.height == scrollView.contentSize.height){
//               loadData()
//            }

        }
    }
}
