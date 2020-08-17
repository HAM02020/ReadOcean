//
//  YDt1ViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/25.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import SnapKit

class YDt1ViewControllerOld: BaseViewController {

    private lazy var listViewModel = YDBooksListViewModel()
    
    
//    private lazy var homeView:HomeView={
//        let v = HomeView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        v.listViewModel = self.listViewModel
//        return v
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    override func setupLayout() {
        //view.addSubview(homeView)
//        homeView.snp.makeConstraints{ make in
////            make.left.equalTo(0)
////            make.width.equalTo(UIScreen.main.bounds.width - 30)
////            make.bottom.equalToSuperview().offset(-100)
////            make.height.equalTo(100)
//            make.edges.equalToSuperview()
//        }
        
    }
    
    
//    @objc func loadData(){
//        refreshControl.beginRefreshing()
//        listViewModel.loadBooks { (isSuccess) in
//            self.tableView?.reloadData()
//            self.refreshControl.endRefreshing()
//        }
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

}
//MARK:绘制UI
//extension YDt1ViewController{
//
//
//
//    private func setupUI(){
//
//        view.backgroundColor = UIColor.red
//
//        //初始化搜索窗口
////        setupSearchController()
////        setupTableView()
////        setupNav()
//    }
//    private func setupNav(){
//        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil),UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: nil),UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)]
//    }
//
//    func setupSearchController(){
//        //MARK:添加searchcontroller
//        searchController = YDSearchController(searchResultsController: nil)
//        //添加进navigationitem
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = true
//
//        //输入框的颜色
//        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
////        //指针颜色
//        searchController.searchBar.searchTextField.tintColor = UIColor.init(hexString: "#706EDB")
////        searchController.searchBar.searchTextField.textColor = UIColor.red
////        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "搜索", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
//
//
//        searchController.delegate = self
//        searchController.searchBar.delegate = self
//    }
//
//    func setupTableView() {
//
//        tableView?.addSubview(refreshControl)
//
//
//        tableView = UITableView(frame: view.bounds, style: .plain)
//        view.addSubview(tableView!)
//
//        //注册nib
//        tableView?.register(UINib.init(nibName: "YDBooksTableViewCell", bundle:.main), forCellReuseIdentifier: "BooksCellId")
//
//
//
//        //设置数据源 和 代理 -> 目的 子类直接实现h数据源方法
//        tableView?.dataSource = self
//        tableView?.delegate = self
//
//        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
//        //取消分割线
//        //tableView?.separatorStyle = .none
//        //预估行高
//        //tableView?.estimatedRowHeight = 300
//
//
//
//        //tableView?.tableHeaderView = searchController.searchBar
//
//        //设置刷新控件
//        //1> 实例化控件
//        //refreshControl = MGRefreshControl()
//
//        //2> 添加到表格视图
//        //tableView?.addSubview(refreshControl!)
//
//        //3> 添加监听方法
//        //refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
//
//        //hidesBottomBarWhenPushed = true
//
//        //设置内容缩进 我这里没必要 因为我没有自定义navigationbar
//        //tableView?.contentInset = UIEdgeInsets(top: self.navigationController?.navigationBar.bounds.height ?? 0, left: 0, bottom: tabBarController?.tabBar.bounds.heigt ?? 49, right: 0)
//    }
//}

