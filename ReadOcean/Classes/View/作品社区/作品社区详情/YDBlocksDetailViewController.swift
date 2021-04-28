//
//  YDBlocksViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/16.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit


class YDBlocksDetailViewController:WMZPageController{
    
    var myBlock: MyBlock?
    
    var blockId:String?
    
    var model:String?
    
    private lazy var categorysTitle = ["全部","评论","绘画","读后感","读书笔记","思维导图","朗诵","背诵"]
    private lazy var categorysConfig = ["","forum_post_pinglun","forum_post_huihua","forum_post_duhougan","forum_post_biji","forum_post_siwei","forum_post_langsong","forum_post_beisong"]
    
    private lazy var headerView: YDBlockDetailHeaderView = {
        let v = YDBlockDetailHeaderView.loadFromNib()
        v.viewModel = myBlock
        
        return v
    }()
    
    private lazy var viewControllers:[UIViewController] = {
        var list = [UIViewController]()
        guard let blockId = blockId else {return list}
        for i in 0..<categorysConfig.count{
            let vc = YDBlockDetailSegmentViewController(category: categorysConfig[i], blockId: blockId)
            vc.categoryName = categorysTitle[i]
            list.append(vc)
        }
        return list
    }()
    
    private lazy var composeBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.contactAdd)
        btn.backgroundColor = UIColor.systemBlue
        return btn
    }()
    
    var scrollPoint = CGPoint.zero
    
    private lazy var params: WMZPageParam = {
        let params = PageParam()
        params.wTitleArr = categorysTitle
        params.wControllers = viewControllers
        
        params.wTopSuspension = true
        params.wBounces = false //false 内部下拉刷新
        params.wFromNavi = true
        //params.wNaviAlpha = false
        params.wMenuTitleSelectColor = UIColor(hexString: "23c993")
        params.wMenuPosition = PageMenuPosition(rawValue: 2)
        //下划线
        params.wMenuAnimal = PageTitleMenu(rawValue: 3)
        params.wMenuIndicatorColor = UIColor(hexString: "23c993")
        params.wMenuHeadView = {[weak self] in
            return self?.headerView
        }
        params.wEventChildVCDidSroll = {[weak self](pageVC:UIViewController?,oldPoint:CGPoint,newPoint:CGPoint,currentScrollView:UIScrollView?) in
            self?.scrollPoint = newPoint
            //self?.configNav(point: self!.scrollPoint)
        }
        return params
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "作品社区"
        self.param = params
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(composePost))
        
    }
    @objc func composePost(){
        let vc = YDBlockPublishPostViewController()
        vc.blockId = blockId
        navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
