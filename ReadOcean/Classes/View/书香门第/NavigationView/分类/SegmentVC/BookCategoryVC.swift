//
//  BookCategoryVC.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/10/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

let BookCategoryTableViewCellId = "BookCategoryTableViewCellId"

class BookCategorysVC: BaseViewController{
    
    //书籍数据列表
    var listViewModel = BooksListViewModel.shared
    
    var categoryParam: String = ""
    
    convenience init(_ categoryParam: String){
        self.init()
        self.categoryParam = categoryParam
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        
        
        t.separatorStyle = .none
        t.rowHeight = 130
        
        t.delegate = self
        t.dataSource = self
        
        
        t.register(UINib(nibName: "BookCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: BookCategoryTableViewCellId)
        
        
        return t
    }()
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
extension BookCategorysVC{
    @objc func loadData(){
    
        LPH.cover(self.view, animated: false)

        listViewModel.getBooksByCategory(category: categoryParam) {[weak self] in
            self?.tableView.reloadData()
            LPH.uncover()
        }
        
    }
}


extension BookCategorysVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.dataDict[categoryParam]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCategoryTableViewCellId, for: indexPath) as! BookCategoryTableViewCell
        cell.viewModel = listViewModel.dataDict[categoryParam]![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = listViewModel.categoriesParams[indexPath.section]
        
        let vc = BookDetailVC()
        vc.bookId = listViewModel.dataDict[key]![indexPath.item].id
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
