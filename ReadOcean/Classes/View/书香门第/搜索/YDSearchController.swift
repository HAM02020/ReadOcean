//
//  YDSearchController.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/3/1.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit

let CellIndentifier = "CellIdentifier"

class YDSearchController: BaseViewController, UISearchBarDelegate, UISearchResultsUpdating{
    var searchController : UISearchController!
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        return t;
    }()
    
    var listTeams : NSArray! //全部数据
    var listFilterTeams : NSArray! //过滤后数据
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //导入外部资源文件,文件名为team.plist
        let plistPath = Bundle.main.path(forResource:"team",ofType:"plist")
        //获取属性列表文件中的全部数据
        self.listTeams = NSArray(contentsOfFile: plistPath!)
        
        self.filterContentForSearchText("", scope: -1)
        
        //实例化UISearchController
        self.searchController = UISearchController(searchResultsController: nil)
        //设置self为更新搜索结果对象
        self.searchController.searchResultsUpdater = self
        //在搜索时,设置背景为灰色
        //self.searchController.dimsBackgroundDuringPresentation = false
        
        //设置搜索范围栏中的按钮
        //self.searchController.searchBar.scopeButtonTitles = ["中文","英文"]
        self.searchController.searchBar.delegate = self
        
        //将搜索栏放到表视图的表头中
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        self.searchController.searchBar.sizeToFit()
        
        searchController.hidesNavigationBarDuringPresentation = false
        
        
        
        //searchController.hidesNavigationBarDuringPresentation = false
        //这里不需要手动把控制器类分配给表视图的委托属性delegate和数据源属性DataSource.因为父类UITableViewController已经并且分配表视图的委托属性delegate和数据源属性dataSource.
        //        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //        //设置表视图委托对象为self
        //        self.tableView.delegate = self
        //        self.tableView.dataSource = self
        //        self.view.addSubview(self.tableView)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func setupLayout() {
        super.setupLayout()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    
    //自定义过滤结果集方法
    func filterContentForSearchText(_ searchText: NSString, scope: Int){
        
        if(searchText.length == 0){
            //查询所有数据,listFilterTeams是可变数组类型NSMutableArray
            self.listFilterTeams = NSMutableArray(array: self.listTeams)
            return
        }
        var tempArray: NSArray!
        if(scope == 0){ //中文,name字段是中文名
            //NSPredicate是谓词,y可以定义一个查询条件,用来在内存中过滤集合对象.format用于设置Predicate字符串格式.本例中SELF代表要查询的对象,SELF.name是查询对象的name字段(字典对象的键或实体对象的属性),contains[c]是包含字符的意思,小写c表示不区分大小写.
            let scopePredicate = NSPredicate(format: "SELF.name contains[c] %@", searchText)
            tempArray = self.listTeams.filtered(using: scopePredicate) as NSArray?
            self.listFilterTeams = NSMutableArray(array: tempArray)
            
        } else if (scope == 1) {
            let scopePredicate = NSPredicate(format: "SELF.image contains[c] %@", searchText)
            tempArray = self.listTeams.filtered(using: scopePredicate) as NSArray?
            self.listFilterTeams = NSMutableArray(array: tempArray)
          
        } else {  //查询所有
            self.listFilterTeams = NSMutableArray(array: self.listTeams)
        }
    }
    
    //实现UISearchBarDelegate协议方法
    //点击搜索范围栏按钮时调用该方法
    func searchBar(_ searchBar: UISearchBar,selectedScopeButtonIndexDidChange selectedScope: Int){
        self.updateSearchResults(for: self.searchController)
    }
    
    //实现UISearchResultUpdating协议方法
    //当搜索栏成为第一响应者,并且内容被改变时调用该方法.
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        self.filterContentForSearchText(searchString! as NSString, scope: searchController.searchBar.selectedScopeButtonIndex)
        self.tableView.reloadData() //搜索完成后,重新加载表视图
        print("重新加载数据")
    }
    
    
    
}


extension YDSearchController: UITableViewDelegate,UITableViewDataSource{
    //因为这是重写父类UITableViewController的方法,所以要加override关键字.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listFilterTeams.count
    }
    
    //表视图单元格显示的时候会调用表视图数据源对象的此方法,为单元格提供显示数据.(每一行单元格都会调用一次)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        //获取可重用单元格对象.
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: CellIndentifier)
        //上一行dequeueResuableCell(withIdentifier:)必须配合下面的判断使用.即先判断是否找到可以重用的单元格.如果没有,则通过单元格构造函数创建单元格对象.
        if(cell == nil){
            //设置单元格样式.(default,subtitle(有图标,主标题和副标题,副标题在主标题下面),value1(有主标题和副主标题,副标题在右边,可以有图标),value2(有主标题和副标题,无图标).)
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: CellIndentifier)
        }
        
        let row = (indexPath as NSIndexPath).row
        let rowDict = self.listFilterTeams[row] as! NSDictionary
        cell.textLabel?.text = rowDict["name"] as? String
        //cell.detailTextLabel?.text = rowDict["image"] as? String
        //let imagePath = String(format: "%@.png", rowDict["image"] as! String)
        //cell.imageView?.image = UIImage(named: imagePath)
        
        cell.accessoryType = .disclosureIndicator //设置扩展视图
        
        
        return cell
    }
}
