//
//  T3RankSegmentVC.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/11/18.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class T3RankSegmentVC: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.backgroundColor = UIColor.blue
        
        
        return UITableView()
    }()
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
