//
//  BookDetailVC.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/9/30.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BookDetailVC:WMZPageController{
    
    var bookId:String?
    
    var model:BookDetail?{
        didSet{
            headerView.viewModel = model
            navigationItem.title = model?.title
            vc1.model = model
            vc2.model = model
        }
    }
    
    let headerView = BookDetailHeaderView.loadFromNib()
    
    let vc1 = BookDetailSegmentVC.initFromStoryBoard(id: "BookDetailSegmentVC")

    let vc2 = BookDetailSegmentVC.initFromStoryBoard(id: "segmentTableViewVC")
    
    let vc3 = BookDetailSegmentVC.initFromStoryBoard(id: "segmentTableViewVC",tableViewType: "course")
    
    var scrollPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "书籍详情"
        
        let params = PageParam()
        params.wTitleArr = ["书籍简介","答题记录","微课视频"]
        params.wControllers = [vc1,vc2,vc3]
        
        params.wTopSuspension = true
        params.wBounces = true
        params.wFromNavi = false
        params.wNaviAlpha = false
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
            self?.configNav(point: self!.scrollPoint)
        }
        self.param = params
        
        loadData()
        
        
    }
    
    func configNav(point:CGPoint,isAppear:Bool = true){
        
        
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: point.y/(400-navigationNormalHeight-statusBarHeight))]
        
        
        
        if isAppear{
            
            navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: point.y/(400-navigationNormalHeight-statusBarHeight))), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0))
        }else{
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        configNav(point: scrollPoint)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        configNav(point: scrollPoint, isAppear: false)
    }
    
}
//MARK:方法
extension BookDetailVC{
    
    func loadData(){
        guard let bookId = bookId else {return}
        networkManager.requestModel(.bookDetail(bookId: bookId), model: BookDetail.self) { (model) in
            guard let model = model else {return}
            self.model = model
            
        }
    }
    
}


