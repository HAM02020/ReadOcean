//
//  YDSearchController.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/3/1.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit
import SwiftyJSON
import EmptyStateKit

let CellIndentifier = "CellIdentifier"

class YDSearchController: BaseViewController, UISearchBarDelegate, UISearchResultsUpdating{
    
    private lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: nil)
        
        //设置self为更新搜索结果对象
        s.searchResultsUpdater = self
        s.searchBar.delegate = self
        
        s.searchBar.sizeToFit()
        s.hidesNavigationBarDuringPresentation = false
        s.obscuresBackgroundDuringPresentation = false //点击搜索bar时不使背景透明
        
        //设置搜索范围栏中的按钮
        //searchController.searchBar.scopeButtonTitles = ["中文","英文"]

        return s
    }()
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        
        return t;
    }()
    private lazy var resultView: UITableView = {
        let t = UITableView()
        //t.isHidden = true
        t.delegate = self
        t.dataSource = self
        
        
        t.register(cellType: YDSearchResultTableViewCell.self)
        
        t.separatorStyle = .none
        t.rowHeight = 130
        
        t.isHidden = true
        return t;
    }()
    
    private lazy var emptyView: YDSearchEmptyView = {
        let v = YDSearchEmptyView()
        v.delegate = self
        view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(navigationExtendHeight)
            make.left.bottom.right.equalToSuperview()
        }
        //v.isHidden = true
        return v
    }()
    
    

    var listFilterTeams = [QueryBook]() //过滤后数据
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.filterContentForSearchText("")
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        shardAccount.saveSearchHistory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func setupLayout() {
        super.setupLayout()
        view.backgroundColor = UIColor.white
        navigationItem.titleView = searchController.searchBar
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(emptyView.snp.edges)
        }
        view.addSubview(resultView)
        resultView.snp.makeConstraints { (make) in
            make.edges.equalTo(emptyView.snp.edges)
        }
    }
    
    func loadData(keyWord: String = "",pageNum: Int = 1){
        if(keyWord.elementsEqual("")){
            listFilterTeams.removeAll();
            tableView.reloadData();
            resultView.reloadData()
            resultView.isHidden = true
            
            return
        }
        networkManager.requestDataList(.bookSearch(keyWord: keyWord, pageNum: pageNum), model: QueryBook.self) { (resList) in
            guard let resList = resList else {return}
            self.listFilterTeams = resList
            self.tableView.reloadData() //搜索完成后,重新加载表视图
            self.resultView.reloadData()
            print("重新加载数据")
            print(resList)
        }
        
    }
    
    
    //自定义过滤结果集方法
    func filterContentForSearchText(_ searchText: String){
        loadData(keyWord: searchText)

    }
    //实现UISearchResultUpdating协议方法
    //当搜索栏成为第一响应者,并且内容被改变时调用该方法.
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text ?? ""
//        if(searchString.elementsEqual("")){listFilterTeams.removeAll();tableView.reloadData();resultView.reloadData();return}
        filterContentForSearchText(searchString)
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("搜索click")
        guard let searchString = searchController.searchBar.text else {return}
        if(!searchString.elementsEqual("")){
            emptyView.addTag(searchString)
        }
        resultView.isHidden = false;
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resultView.isHidden = true
    }
    
    
}


extension YDSearchController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(listFilterTeams.count <= 0){
            emptyView.isHidden = false
        }else{
            emptyView.isHidden = true
            
        }
        
        
        return listFilterTeams.count
    }
    
    //表视图单元格显示的时候会调用表视图数据源对象的此方法,为单元格提供显示数据.(每一行单元格都会调用一次)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if(tableView == self.tableView){
            //获取可重用单元格对象.
            cell = tableView.dequeueReusableCell(withIdentifier: CellIndentifier)
            if(cell == nil){

                cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: CellIndentifier)
            }
            
            let row = (indexPath as NSIndexPath).row
            let rowModel = self.listFilterTeams[row]
            cell?.textLabel?.text = rowModel.title
            //cell.detailTextLabel?.text = rowDict["image"] as? String
            //let imagePath = String(format: "%@.png", rowDict["image"] as! String)
            //cell.imageView?.image = UIImage(named: imagePath)
            
            cell?.accessoryType = .disclosureIndicator //设置扩展视图
            
            
            
        }
        if(tableView == resultView){
            let dcell = tableView.dequeueReusableCell(for: indexPath, cellType: YDSearchResultTableViewCell.self)
            dcell.bookId = listFilterTeams[indexPath.row].id
            
            cell = dcell
        }
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BookDetailVC()
        vc.bookId = listFilterTeams[indexPath.item].id
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension YDSearchController:YDSearchEmptyViewDelegate{
    func searchEmptyView(didSelect tag: String) {
        searchController.searchBar.text = tag
        
    }
}
