//
//  YDSearchController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/6/11.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDSearchController: UISearchController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI(){
        self.view.backgroundColor = UIColor.black
                //FIXME:出现只能取消输入不能居中的BUG
        //        searchController?.searchBar.setPositionAdjustment(UIOffset(horizontal: ((searchController?.searchBar.frame.width)! - 100)/2, vertical: 0), for: .search)
                
        searchBar.placeholder = "搜索"
        //searchBar.tintColor = UIColor.clear
        //去掉边框线
        searchBar.searchBarStyle = .minimal
        //没有输入的时候可以点击搜索按钮
        searchBar.enablesReturnKeyAutomatically = false
        //取消按钮颜色
        searchBar.tintColor = UIColor.white
        //FIXME:这句话不起作用 必须在主界面中设置才有用
        //self.searchBar.searchTextField.backgroundColor = .red
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
