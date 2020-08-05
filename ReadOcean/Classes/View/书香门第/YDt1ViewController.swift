//
//  YDt1ViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/25.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDt1ViewController: YDBaseViewController {

    var tableView : UITableView?
    lazy var refreshControl = UIRefreshControl()
    private lazy var listViewModel = YDBooksListViewModel()
    lazy var searchController = YDSearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //使用xib创建的页面
//        let v = YD1View.yd1View()
//        v.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 44)
//        view.addSubview(v)

        
        setupUI()
        loadData()
        let navView = UIView(frame: CGRect(x: 0, y: 0, width:self.view.bounds.width, height: 64))
        navView.backgroundColor = UIColor.red
        tableView?.tableHeaderView = navView

    }
    @objc func loadData(){
        refreshControl.beginRefreshing()
        listViewModel.loadBooks { (isSuccess) in
            self.tableView?.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView?.backgroundColor=UIColor(hexString: "#f2f2f2")
        //给tableview添加背景图片
        //let backgroundImage = UIImage(named: "background1.png")
        //let imageView = UIImageView(image: backgroundImage)
        //self.tableView?.backgroundView = imageView
    }
    

}
//MARK:绘制UI
extension YDt1ViewController{
    
    
    
    private func setupUI(){
        
        view.backgroundColor = UIColor.red

        //初始化搜索窗口
        setupSearchController()
        setupTableView()
        setupNav()
    }
    private func setupNav(){
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil),UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: nil),UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)]
    }
    
    func setupSearchController(){
        //MARK:添加searchcontroller
        searchController = YDSearchController(searchResultsController: nil)
        //添加进navigationitem
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        //输入框的颜色
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
//        //指针颜色
        searchController.searchBar.searchTextField.tintColor = UIColor.init(hexString: "#706EDB")
//        searchController.searchBar.searchTextField.textColor = UIColor.red
//        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "搜索", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
        
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
    
    func setupTableView() {

        tableView?.addSubview(refreshControl)


        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView!)
        
        //注册nib
        tableView?.register(UINib.init(nibName: "YDBooksTableViewCell", bundle:.main), forCellReuseIdentifier: "BooksCellId")
        
        
        
        //设置数据源 和 代理 -> 目的 子类直接实现h数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self
        
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        //取消分割线
        //tableView?.separatorStyle = .none
        //预估行高
        //tableView?.estimatedRowHeight = 300
        
        
        
        //tableView?.tableHeaderView = searchController.searchBar
        
        //设置刷新控件
        //1> 实例化控件
        //refreshControl = MGRefreshControl()
        
        //2> 添加到表格视图
        //tableView?.addSubview(refreshControl!)
        
        //3> 添加监听方法
        //refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        //hidesBottomBarWhenPushed = true
        
        //设置内容缩进 我这里没必要 因为我没有自定义navigationbar
        //tableView?.contentInset = UIEdgeInsets(top: self.navigationController?.navigationBar.bounds.height ?? 0, left: 0, bottom: tabBarController?.tabBar.bounds.heigt ?? 49, right: 0)
    }
}

extension YDt1ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = (listViewModel.booksList.count)/2
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let vm1 = listViewModel.booksList[2*indexPath.row]
        let vm2 = listViewModel.booksList[2*indexPath.row+1]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BooksCellId", for: indexPath) as? YDBooksTableViewCell
            else{
            return UITableViewCell()
        }
        cell.backgroundColor = UIColor.clear
        
        // 用视图模型设置cell
        cell.vm1 = vm1
        cell.vm2 = vm2
        
        return cell

        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 250
    }

}

//MARK:searchBar的代理
extension YDt1ViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search button clicked")
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        //searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .search)
        
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .search)
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    }
}
//MARK:searchController的代理
extension YDt1ViewController:UISearchControllerDelegate{
    func willPresentSearchController(_ searchController: UISearchController) {
//        navigationController?.navigationBar.isTranslucent = true
//        searchController.searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .search)
    }
    func willDismissSearchController(_ searchController: UISearchController) {
//        navigationController?.navigationBar.isTranslucent = false
//        searchController.searchBar.setPositionAdjustment(UIOffset(horizontal: ((searchController.searchBar.frame.width) - 100)/2, vertical: 0), for: .search)
    }
}
