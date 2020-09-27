//
//  DiscoverStoryTableViewCollectionViewCell.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/9/27.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

let DiscoverStoryDetailTableViewCellType = "DiscoverStoryDetailTableViewCellType"

class DiscoverStoryTableViewCollectionViewCell:BaseCollectionViewCell{
    
    //private lazy var listViewModel = 
    
    deinit {
        timer?.invalidate()
    }
    
    private lazy var icon:UIImageView = {
        let img = UIImage(named: "story")?.reSizeImage(reSize: CGSize(width: 20, height: 20))
        let imgV = UIImageView(image: img)
        return imgV
    }()
    
    private lazy var title:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        label.text = "故事新编"
        label.font = UIFont.systemFont(ofSize: 12,weight: .regular)
        return label
    }()
    
    private lazy var joinCountLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        
        let txt = NSMutableAttributedString(string: "已有2998人参与故事新编")
        txt.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: NSRange(location: 2, length: 4))
        
        label.textColor = UIColor.darkGray
        label.attributedText = txt
        label.font = UIFont.systemFont(ofSize: 10)
        
        
        return label
    }()
    
    private lazy var loopView:UITableView = {
        let t = UITableView()
        
        t.showsHorizontalScrollIndicator = false
        t.showsVerticalScrollIndicator = false
        t.isScrollEnabled = false
        t.separatorStyle = .none
        t.register(UINib(nibName: "DiscoverStoryDetailTableViewCell", bundle: nil), forCellReuseIdentifier: DiscoverStoryDetailTableViewCellType)
        t.rowHeight = 40
        t.delegate = self
        t.dataSource = self
        return t
    }()
    
    private lazy var line : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.darkGray
        
        return label
    }()
    
    private lazy var talkButton:WBTittleButton = {
        let img = UIImage(named: "arrow_right")?.reSizeImage(reSize: CGSize(width: 15, height: 15))
        let btn = WBTittleButton(title: "我要留言", image: img)
        btn.tintColor = UIColor.darkGray
        btn.imagePosition(style: .right, spacing: 5)

        return btn
    }()
    
    var index = 0
    
    private var timer:Timer?
    
    @objc func updataTimer(){

        loopView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: true)
        if index < 9{
            index += 1
        }else{
            index = 0
        }
        
    }
    
    override func setupLayout() {
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updataTimer), userInfo: nil, repeats: true)
        
        contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(10)
            
        }
        contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon.snp.centerY)
            make.left.equalTo(icon.snp.right).offset(5)
        }
        contentView.addSubview(joinCountLabel)
        joinCountLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalTo(icon.snp.centerY)
        }
        
        contentView.addSubview(talkButton)
        talkButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalTo(talkButton.snp.top)
            
        }
        
        contentView.addSubview(loopView)
        loopView.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(line.snp.top)
            
        }
        
    }
    
    
}
extension DiscoverStoryTableViewCollectionViewCell:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverStoryDetailTableViewCellType, for: indexPath)
        
        return cell
    }
    
    
    
   
}
