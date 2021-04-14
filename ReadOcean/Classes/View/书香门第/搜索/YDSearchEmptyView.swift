//
//  YDSearchEmptyView.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/14.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit

class YDSearchEmptyView: UIView,TTTagViewDelegate{
    
    var delegate:YDSearchEmptyViewDelegate?
    
    lazy var tagView : TTTagView = {
        let tagV = TTTagView()
        tagV.delegate = self
        tagV.tagsArray = shardAccount.searchHistoryArray
        tagV.tagBackgroundColor = UIColor.white
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
            make.top.equalTo(label.snp.bottom)
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
    
    func updateTagView(){
        tagView.tagsArray.removeAll()
        tagView.tagsArray = shardAccount.searchHistoryArray
    }

    
    func addTag(_ tag: String){
        shardAccount.searchHistoryArray = shardAccount.searchHistoryArray.filter { (historyStr) -> Bool in
            return historyStr != tag
        }
        shardAccount.searchHistoryArray.insert(tag, at: 0)
        updateTagView()
    }
    
    @objc func clearAllTags(){
        shardAccount.searchHistoryArray.removeAll()
        updateTagView()
    }

    func ttTageViewDidsSelect(_ item: TTTagItem) {
        guard let delegate = delegate else {return}
        delegate.searchEmptyView(didSelect: item.model as! String)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            item.isSelected = false
        }

    }
    
}

protocol YDSearchEmptyViewDelegate {
    func searchEmptyView(didSelect tag:String);
}
