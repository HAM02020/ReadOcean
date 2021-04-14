//
//  DiscoverBooksTableView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/25.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

let DiscoverTableViewCellType = "DiscoverTableViewCellType"

class DiscoverBooksHeaderTableView : BaseCollectionViewCell{
    
    private lazy var listViewModel = BooksListViewModel.shared
    
    var bookDelegate:DiscoverBookDelegate?
    
    private lazy var tableView:UITableView = {
        let t = UITableView()
        t.automaticallyAdjustsScrollIndicatorInsets = false
        t.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        t.delegate = self
        t.dataSource = self
        //transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))

        t.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        t.separatorStyle = .none
        
        t.showsVerticalScrollIndicator = false
        t.showsHorizontalScrollIndicator = false
        
        //优化
        t.rowHeight = 320
        t.estimatedRowHeight = 320
        
        
        
        t.register(UINib(nibName: "DiscoverBooksTableViewCell", bundle: nil), forCellReuseIdentifier: DiscoverTableViewCellType)
        return t
    }()
    
    override func setupLayout() {
        backgroundColor = UIColor.white
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(snp.width)
            make.width.equalTo(330)
        }
        tableView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
    }

}
extension DiscoverBooksHeaderTableView :UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.dataDict.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverTableViewCellType, for: indexPath) as! DiscoverBookTableViewCell
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        cell.delegate = bookDelegate
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let key = listViewModel.categoriesParams[indexPath.row]
        let name = listViewModel.categoryName[indexPath.row]
        let cell = (cell as! DiscoverBookTableViewCell)
        cell.listViewModel = listViewModel.dataDict[key]!
        cell.title.text = name + "排行榜"
        
    }
    
}
