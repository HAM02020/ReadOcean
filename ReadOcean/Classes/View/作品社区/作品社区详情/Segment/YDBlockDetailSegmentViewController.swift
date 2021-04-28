//
//  YDBlockDetailSegmentViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/16.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit

class YDBlockDetailSegmentViewController:BaseViewController,WMZPageProtocol{
    
    let YDBlockDetailPostNormalTableViewCell = "YDBlockDetailPostNormalTableViewCell"
    let YDBlockDetailPostSoundTableViewCell = "YDBlockDetailPostSoundTableViewCell"
    
    var category: String!
    var categoryName: String?
    var blockId: String!
    var viewModel: BlockPostsListViewModel!
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(category:String, blockId:String) {
        self.init()
        self.category = category
        self.blockId = blockId
        self.viewModel = BlockPostsListViewModel(category: category, blockId: blockId)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func getMyScrollView() -> UIScrollView {
        return tableView
    }
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.estimatedRowHeight = 125
        t.register(UINib(nibName: "YDBlockDetailPostNormalTableViewCell", bundle: nil), forCellReuseIdentifier: YDBlockDetailPostNormalTableViewCell)
        t.register(UINib(nibName: "YDBlockDetailPostSoundTableViewCell", bundle: nil), forCellReuseIdentifier: YDBlockDetailPostSoundTableViewCell)
        t.separatorStyle = .none
        // 刷新控件
        t.myHead = URefreshHeader {[weak self] in
            self?.loadData(isLoadMore: false)
        }
        t.gx_footer = GXRefreshNormalFooter{ [weak self] in
            self?.loadData(isLoadMore: true)
        }
        //优化
        t.layer.isOpaque = true
        t.layer.drawsAsynchronously = true
        //栅格化
        //必须指定分辨率 不然h很模糊
        t.layer.shouldRasterize = true
        //分辨率
        t.layer.rasterizationScale = UIScreen.main.scale
        return t
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(isLoadMore: false)
    }
    
    @objc func loadData(isLoadMore: Bool){
        viewModel.getPosts(isLoadMore: isLoadMore) {[weak self] (isSuccess,isNoMoreData) in
            if(!isSuccess){
                return
            }
            self?.tableView.reloadData()
            self?.tableView.myHead.endRefreshing()
            self?.tableView.gx_footer?.endRefreshing(isNoMore: isNoMoreData)
        }
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension YDBlockDetailSegmentViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if(category.elementsEqual("forum_post_langsong") || category.elementsEqual("forum_post_beisong")){
            cell = tableView.dequeueReusableCell(withIdentifier: YDBlockDetailPostSoundTableViewCell, for: indexPath)
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: YDBlockDetailPostNormalTableViewCell, for: indexPath)
        }
        let postCell = (cell as! YDBlockDetailPostTableViewCell)
        postCell.viewModel = viewModel.posts[indexPath.row]
        postCell.categoryName = categoryName
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = viewModel.posts[indexPath.row]
        
        if(post.media!.hasSuffix("jpeg") || post.media!.hasSuffix("jpg") || post.media!.hasSuffix("png")){
            return 350
        }else if(post.media!.hasSuffix("mp3")){
            
        }else{
            viewModel.posts[indexPath.row].picHeight = 0
        }
        return 125
    }
    
}
