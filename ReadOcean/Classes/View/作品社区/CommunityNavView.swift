//
//  CommunityNavView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/20.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit


class CommunityNavView: UIView {
    
    private lazy var titleLabel:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "作品社区"
        txt.font = .monospacedSystemFont(ofSize: 24, weight: .heavy)
        txt.textColor = .black
        txt.textAlignment = .center
        txt.numberOfLines = 0
        return txt
    }()
    
    private lazy var stackView: UIStackView = {
        let stackV = UIStackView()
        stackV.spacing = 10
        stackV.alignment = .fill
        stackV.distribution = .fillEqually
        return stackV
    }()
    private lazy var categoryBtn:WBTittleButton = {
        let img = UIImage(named: "fenlei")?.reSizeImage(reSize: CGSize(width: 15, height: 15))
       let btn = WBTittleButton(title: "分类", image: img)
        
        return btn
    }()
    private lazy var searchBtn:WBTittleButton = {
        let img = UIImage(named: "sousuo")?.reSizeImage(reSize: CGSize(width: 15, height: 15))
       let btn = WBTittleButton(title: "搜索", image: img)

        return btn
    }()
    private lazy var moreBtn:WBTittleButton = {
        let img = UIImage(named: "gengduo")?.reSizeImage(reSize: CGSize(width: 15, height: 15))
       let btn = WBTittleButton(title: "更多", image: img)
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var defaultValue: CGFloat = 0
    private var selfDefaultHeight: CGFloat = 0
    private let MaxValue: CGFloat = (screenWidth - 20)/2
    
    public var value: CGFloat? {
            didSet {
                self.layoutIfNeeded()
                print("didset nav 的 value")
                if let value = value {
    //                print("didSet:", value)
                    if defaultValue == 0 {
                        // 设置默认值
                        defaultValue = value
                        selfDefaultHeight = self.frame.size.height
    //                    print("设置默认值:", defaultValue)
    //                    print("自身高度:", selfDefaultHeight)
                    } else {
                        var changeValue = ((-defaultValue)-(-value))
                        //var changeValue = value - defaultValue
                        if changeValue < 0 {
                            changeValue = 0
                        }
                        if changeValue > MaxValue {
                            changeValue = MaxValue
                        }
                        if value > defaultValue {
                            // 往上推
                            self.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: changeValue/100)
                            
                        }
                        if value <= defaultValue {
                            // 往下推
                            self.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: changeValue/100)
                        }

                    }
                }
            }

        }
    private func setupLayout(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(30)
            make.width.equalTo(screenWidth/3)
        }
        
        //stackView.addArrangedSubview(searchBtn)
        //stackView.addArrangedSubview(categoryBtn)
        //stackView.addArrangedSubview(moreBtn)
//        addSubview(stackView)
//        stackView.snp.makeConstraints { (make) in
//            make.bottom.equalToSuperview().offset(-15)
//            make.right.equalToSuperview().offset(-10)
//            make.width.equalTo(screenWidth/3)
//            make.height.equalTo(30)
//        }
        addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
                    make.bottom.equalToSuperview().offset(-15)
                    make.right.equalToSuperview().offset(-10)
                    
                    make.height.equalTo(30)
        }
    }
}


