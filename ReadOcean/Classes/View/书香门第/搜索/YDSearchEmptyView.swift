//
//  YDSearchEmptyView.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/14.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit

class YDSearchEmptyView: UIView{
    
    var delegate:YDSearchEmptyViewDelegate?
    

    
    lazy var tagView : TagListView = {
        let tagV = TagListView()
        tagV.delegate = self
        //tagV.borderWidth = 1
        tagV.cornerRadius = 15
        tagV.marginX = 10
        tagV.marginY = 10
        tagV.paddingX = 5
        tagV.paddingY = 5
        
        tagV.tagLineBreakMode = .byTruncatingTail
        tagV.tagBackgroundColor = UIColor(hexString: "EEEEEE")
        tagV.textColor = UIColor.darkGray
        tagV.textFont = UIFont.monospacedSystemFont(ofSize: 18, weight: .regular)
        
        
        tagV.addTags(shardAccount.searchHistoryArray)
        return tagV
    }()
    lazy var blueBlock: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        v.backgroundColor = UIColor.systemBlue
        
        return v
    }()
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "历史搜索"
        label.sizeToFit()
        return label
    }()
    lazy var clearBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "垃圾桶")?.reSizeImage(reSize: CGSize(width: 24, height: 24)), for: .normal)
        btn.addTarget(self, action: #selector(clearAllTags), for: .touchUpInside)
        return btn;
    }()
    
    
    
    
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        addSubview(blueBlock)
        addSubview(label)
        addSubview(tagView)
        addSubview(clearBtn)
        blueBlock.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview()
            make.width.equalTo(5)
            make.height.equalTo(30)
        }
        label.snp.makeConstraints { (make) in
            make.top.equalTo(blueBlock)
            make.left.equalTo(blueBlock.snp.right).offset(5)
            make.height.equalTo(30)
            make.width.lessThanOrEqualToSuperview()
        }
        tagView.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        clearBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(blueBlock.snp.centerY)
            make.right.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateAccountSearchHistory(){
        shardAccount.searchHistoryArray.removeAll()
        shardAccount.searchHistoryArray = tagView.tagViews.map{$0.title(for: UIControl.State()) ?? ""}
    }

    
    func addTag(_ tag: String){
        tagView.removeTag(tag)
        tagView.insertTag(tag, at: 0)
        shardAccount.searchHistoryArray.insert(tag, at: 0)
        updateAccountSearchHistory()
    }
    
    @objc func clearAllTags(){
        tagView.removeAllTags()
        updateAccountSearchHistory()
    }

    
}

extension YDSearchEmptyView:TagListViewDelegate{
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        guard let delegate = delegate else {return}
        delegate.searchEmptyView(didSelect: title)
    }
}

protocol YDSearchEmptyViewDelegate {
    func searchEmptyView(didSelect tag:String);
}
