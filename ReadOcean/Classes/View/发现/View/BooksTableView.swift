//
//  BooksTableView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/21.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

let DiscoverTableViewCellType = "DiscoverTableViewCellType"

class BooksTableView: UITableView {

    private lazy var listViewModel = BooksListViewModel()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame:frame,style:style)
        
        automaticallyAdjustsScrollIndicatorInsets = false
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        delegate = self
        dataSource = self
        //transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        backgroundColor = UIColor.yellow
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        separatorStyle = .none
        
        register(UINib(nibName: "DiscoverBooksTableViewCell", bundle: nil), forCellReuseIdentifier: DiscoverTableViewCellType)
        
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func loadData(){
        
        ProgressHUD.show()

        listViewModel.getBooks {[weak self] in
            self?.reloadData()
            ProgressHUD.showSucceed()
        }
        
    }
    
    
}

extension BooksTableView:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.dataDict.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverTableViewCellType, for: indexPath) as! DiscoverBookTableViewCell
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        let key = listViewModel.categoriesParams[indexPath.row]
        cell.listViewModel = listViewModel.dataDict[key]!
        return cell
    }
    
    
}
