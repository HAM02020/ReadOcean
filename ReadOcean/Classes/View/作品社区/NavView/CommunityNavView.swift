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
    private lazy var searchBtn:WBTittleButton = {
        let img = UIImage(named: "sousuo")?.reSizeImage(reSize: CGSize(width: 15, height: 15))
        let btn = WBTittleButton(title: "搜索", image: img)
        btn.addTarget(self, action: #selector(searchBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    var searchBtnClickClosure: (()->())?
    
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
    

    private func setupLayout(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(30)
            make.width.equalTo(screenWidth/3)
        }
        
        addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
                    make.bottom.equalToSuperview().offset(-15)
                    make.right.equalToSuperview().offset(-10)
                    
                    make.height.equalTo(30)
        }
    }
    
    @objc func searchBtnClick(_ sender:UIButton){
        guard let searchBtnClickClosure = searchBtnClickClosure else {return}
        searchBtnClickClosure()
    }
}


