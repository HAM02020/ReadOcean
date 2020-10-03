//
//  BookDetailVC.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/9/30.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BookDetailVC:WMZPageController{
    

    
    let vc1 = BookDetailSegmentVC.initFromStoryBoard()

    let vc2 = YDt5ViewController()
    
    let vc3 = YDt2ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let params = PageParam()
        params.wTitleArr = ["书籍简介","答题记录","微课视频"]
        params.wControllers = [vc1,vc2,vc3]
        
        params.wTopSuspension = true
        params.wBounces = true
        params.wFromNavi = true
        params.wNaviAlpha = true
        params.wMenuTitleSelectColor = UIColor(hexString: "23c993")
        params.wMenuPosition = PageMenuPosition(rawValue: 2)
        //下划线
        params.wMenuAnimal = PageTitleMenu(rawValue: 3)
        params.wMenuIndicatorColor = UIColor(hexString: "23c993")
        params.wMenuHeadView = {
            let v = BookDetailHeaderView.loadFromNib()
            return v
        }
        
        self.param = params
        
    }
    
}



