//
//  HomeNavView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/14.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

typealias NavBtnClickEventBlock = ()->Void

class HomeNavView: UIView {
    //搜索按钮点击 回调
    private var searchBtnClickClosure : NavBtnClickEventBlock?
    
    private lazy var titleLabel:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "阅读海洋"
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
        btn.addTarget(self, action: #selector(searchBtnClick), for: .touchUpInside)
        return btn
    }()
    private lazy var moreBtn:WBTittleButton = {
        let img = UIImage(named: "gengduo")?.reSizeImage(reSize: CGSize(width: 15, height: 15))
       let btn = WBTittleButton(title: "更多", image: img)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
                        var changeValue = ((-defaultValue)-(-value))*0.5
                        //var changeValue = value - defaultValue
                        if changeValue < 0 {
                            changeValue = 0
                        }

                        if changeValue >= 0 && changeValue < 105 {
//                            self.snp.updateConstraints { (make) in
//                                make.height.equalTo(selfDefaultHeight - changeValue/3)
//                            }
                        }

                        if changeValue > MaxValue {
//                            self.snp.updateConstraints { (make) in
//                                make.height.equalTo(selfDefaultHeight - 105/3)
//                            }
//                            stackView.snp.updateConstraints { (make) in
//                                make.top.equalTo(searchBtn.snp_bottom).offset(10 - 90/2)
//                                make.width.equalTo(screenWidth - 40 - MaxValue)
//                            }

                            changeValue = MaxValue
                        }

                        if changeValue > 100 {
//                            searchBtn.backgroundColor = UIColor.init(red: 236/255, green: 236/255, blue: 236/255, alpha: changeValue/100)
//                            msgBtn.setImage(UIImage(named: "sep_Message_Bubble"), for: .normal)
                        } else {
//                            msgBtn.setImage(UIImage(named: "sep_Message_White"), for: .normal)
//                            searchBtn.backgroundColor = .init(red: 1, green: 1, blue: 1, alpha: 0.5)
                        }
                        
                        if changeValue <= 30 {
//                            topBtn.setTitle("排行", for: .normal)
//                            VIPBtn.setTitle("VIP", for: .normal)
//                            subscibeBtn.setTitle("订阅", for: .normal)
//                            classifyBtn.setTitle("分类", for: .normal)
//
//                            topBtn.setImage(UIImage(named: "home_1_default"), for: .normal)
//                            VIPBtn.setImage(UIImage(named: "home_2_default"), for: .normal)
//                            subscibeBtn.setImage(UIImage(named: "home_3_default"), for: .normal)
//                            classifyBtn.setImage(UIImage(named: "home_4_default"), for: .normal)

                        } else {
//                            topBtn.setTitle("", for: .normal)
//                            VIPBtn.setTitle("", for: .normal)
//                            subscibeBtn.setTitle("", for: .normal)
//                            classifyBtn.setTitle("", for: .normal)
//
//                            topBtn.setImage(UIImage(named: "home_1"), for: .normal)
//                            VIPBtn.setImage(UIImage(named: "home_2"), for: .normal)
//                            subscibeBtn.setImage(UIImage(named: "home_3"), for: .normal)
//                            classifyBtn.setImage(UIImage(named: "home_4"), for: .normal)
                        }
                        
                        
                        if changeValue >= 0 && changeValue <= 90.0 {
//                            stackView.snp.updateConstraints { (make) in
//                                make.top.equalTo(searchBtn.snp_bottom).offset(10 - changeValue/2)
//                                make.width.equalTo(screenWidth - 40 - changeValue)
//                            }
                        } else if changeValue >= 0 && changeValue <= MaxValue {
//                            stackView.snp.updateConstraints { (make) in
//                                make.top.equalTo(searchBtn.snp_bottom).offset(10 - (90/2))
//                                make.width.equalTo(screenWidth - 40 - changeValue)
//                            }
                        }

                        if value > defaultValue {
                            // 往上推
                            self.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: changeValue/100)
                            
                            if changeValue <= MaxValue {
//                                searchBtn.snp.updateConstraints({ (make) in
//                                    make.width.equalTo(screenWidth - 85 - changeValue)
//                                })
                            }
                        }
                        if value <= defaultValue {
                            // 往下推
                            self.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: changeValue/100)
                            
                            var width: CGFloat = searchBtn.frame.size.width + changeValue
                            if changeValue <= 0 {
                                width = screenWidth - 85
                            }
//                            searchBtn.snp.updateConstraints({ (make) in
//                                make.width.equalTo(width)
//                            })
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
        
        stackView.addArrangedSubview(searchBtn)
        stackView.addArrangedSubview(categoryBtn)
        stackView.addArrangedSubview(moreBtn)
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(screenWidth/3)
            make.height.equalTo(30)
        }
    }
}

extension HomeNavView{
    
    
    func searchBtnClickClosure(_ closure:NavBtnClickEventBlock?){
        searchBtnClickClosure = closure
    }
    
    @objc func searchBtnClick(){
        guard let closure = searchBtnClickClosure
            else { return }
        closure()
    }
}
