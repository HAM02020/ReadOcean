//
//  DiscoverBooksTableView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/25.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class DiscoverBooksTableView : UITableView{
    
    override init(frame: CGRect, style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    func config(){
        automaticallyAdjustsScrollIndicatorInsets = false
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        delegate = self
        dataSource = self
        //transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))

        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        separatorStyle = .none
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        //优化
        rowHeight = 320
        estimatedRowHeight = 320
        
        
        
        register(UINib(nibName: "DiscoverBooksTableViewCell", bundle: nil), forCellReuseIdentifier: DiscoverTableViewCellType)
    }
}
extension DiscoverBooksTableView :UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.dataDict.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverTableViewCellType, for: indexPath) as! DiscoverBookTableViewCell
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
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
