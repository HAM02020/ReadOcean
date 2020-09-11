//
//  DiscoverNavView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/7.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class DiscoverNavView: UIView {
    private let MaxValue: CGFloat = (screenWidth - 20)/2
    
    private lazy var whiteView: UIView = {
        let v = UIView()
        return v
    }()
    
    private lazy var msgBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "oceanworld_white"), for: .normal)
        return btn
    }()

    private lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "classify_search_btn"), for: .normal)
        btn.setTitle(" 安徒生童话", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13)
        btn.titleLabel?.textAlignment = .left
        btn.backgroundColor = .init(red: 1, green: 1, blue: 1, alpha: 0.5)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    private lazy var stackView: UIStackView = {
        let stackV = UIStackView()
        stackV.spacing = 10
        stackV.alignment = .fill
        stackV.distribution = .fillEqually
        return stackV
    }()

    private lazy var rankBtn: WBTittleButton = {
        let btn = WBTittleButton(title: "排行榜", image: UIImage(named: "rank_white"))
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    private lazy var weClassBtn: WBTittleButton = {
        let btn = WBTittleButton(title: "名师微课", image: UIImage(named: "weclass_white"))
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    private lazy var storyBtn: WBTittleButton = {
        let btn = WBTittleButton(title: "故事新编", image: UIImage(named: "story_white"))
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    private lazy var parentBtn: WBTittleButton = {
        let btn = WBTittleButton(title: "家长阅读", image: UIImage(named: "parent_white"))
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    public var defaultSearch: String? {
        didSet {
            if let defaultSearch = defaultSearch {
                searchBtn.setTitle("  " + defaultSearch, for: .normal)
            }
        }
    }
    
    private var defaultValue: CGFloat = 0
    private var selfDefaultHeight: CGFloat = 0

    public var value: CGFloat? {
        didSet {
            self.layoutIfNeeded()
            if let value = value {
//                print("didSet:", value)
                if defaultValue == 0 {
                    // 设置默认值
                    defaultValue = value
                    selfDefaultHeight = self.frame.size.height
//                    print("设置默认值:", defaultValue)
//                    print("自身高度:", selfDefaultHeight)
                } else {
                    var changeValue = (-defaultValue)-(-value)
                    if changeValue < 0 {
                        changeValue = 0
                    }

                    if changeValue >= 0 && changeValue < 105 {
                        self.snp.updateConstraints { (make) in
                            make.height.equalTo(selfDefaultHeight - changeValue/3)
                        }
                    }

                    if changeValue > MaxValue {
                        self.snp.updateConstraints { (make) in
                            make.height.equalTo(selfDefaultHeight - 105/3)
                        }
                        stackView.snp.updateConstraints { (make) in
                            make.top.equalTo(searchBtn.snp_bottom).offset(10 - 90/2)
                            make.width.equalTo(screenWidth - 40 - MaxValue)
                        }

                        changeValue = MaxValue
                    }

                    if changeValue > 100 {
                        searchBtn.backgroundColor = UIColor.init(red: 236/255, green: 236/255, blue: 236/255, alpha: changeValue/100)
                        msgBtn.setImage(UIImage(named: "oceanworld"), for: .normal)
                    } else {
                        msgBtn.setImage(UIImage(named: "oceanworld_white"), for: .normal)
                        searchBtn.backgroundColor = .init(red: 1, green: 1, blue: 1, alpha: 0.5)
                    }
                    
                    if changeValue <= 30 {
                        rankBtn.setTitle("排行榜", for: .normal)
                        weClassBtn.setTitle("名师微课", for: .normal)
                        storyBtn.setTitle("故事新编", for: .normal)
                        parentBtn.setTitle("家长阅读", for: .normal)
                        
                        rankBtn.setImage(UIImage(named: "rank_white"), for: .normal)
                        weClassBtn.setImage(UIImage(named: "weclass_white"), for: .normal)
                        storyBtn.setImage(UIImage(named: "story_white"), for: .normal)
                        parentBtn.setImage(UIImage(named: "parent_white"), for: .normal)

                    } else {
                        rankBtn.setTitle("", for: .normal)
                        weClassBtn.setTitle("", for: .normal)
                        storyBtn.setTitle("", for: .normal)
                        parentBtn.setTitle("", for: .normal)
                        
                        rankBtn.setImage(UIImage(named: "rank"), for: .normal)
                        weClassBtn.setImage(UIImage(named: "weclass"), for: .normal)
                        storyBtn.setImage(UIImage(named: "story"), for: .normal)
                        parentBtn.setImage(UIImage(named: "parent"), for: .normal)
                    }
                    
                    
                    if changeValue >= 0 && changeValue <= 90.0 {
                        stackView.snp.updateConstraints { (make) in
                            make.top.equalTo(searchBtn.snp.bottom).offset(10 - changeValue/2)
                            make.width.equalTo(screenWidth - 40 - changeValue)
                        }
                    } else if changeValue >= 0 && changeValue <= MaxValue {
                        stackView.snp.updateConstraints { (make) in
                            make.top.equalTo(searchBtn.snp.bottom).offset(18 - (90/2))
                            make.width.equalTo(screenWidth - 40 - changeValue)
                        }
                    }

                    if value > defaultValue {
                        // 往上推
                        self.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: changeValue/100)
                        
                        if changeValue <= MaxValue {
                            searchBtn.snp.updateConstraints({ (make) in
                                make.width.equalTo(screenWidth - 85 - changeValue)
                            })
                        }
                    }
                    if value <= defaultValue {
                        // 往下推
                        self.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: changeValue/100)
                        
                        var width: CGFloat = searchBtn.frame.size.width + changeValue
                        if changeValue <= 0 {
                            width = screenWidth - 85
                        }
                        searchBtn.snp.updateConstraints({ (make) in
                            make.width.equalTo(width)
                        })
                    }

                }
            }
        }

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(msgBtn)
        msgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(38)
            make.left.equalTo(20)
            make.width.height.equalTo(35)
            
        }
        
        addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(65)
            make.height.equalTo(35)
            make.width.equalTo(screenWidth - 85)
        }
        

        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBtn.snp.bottom).offset(10)
            make.right.equalTo(-30)
            make.height.equalTo(35)
            make.width.equalTo(screenWidth - 40)
        }
        stackView.addArrangedSubview(rankBtn)
        stackView.addArrangedSubview(weClassBtn)
        stackView.addArrangedSubview(storyBtn)
        stackView.addArrangedSubview(parentBtn)
        
    }
}
