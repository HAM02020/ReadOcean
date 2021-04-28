//
//  YDBookQuestionTableViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/23.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit

class YDBookQuestionTableViewCell: BaseTableViewCell{
    
    var question:String?{
        didSet{
            guard let question = question else {return}
            descLabel.text = question
        }
    }
    
    private lazy var descLabel: UILabel = {
        let l = UILabel()
        l.text = "这是一道题目"
        l.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .bold)
        l.textColor = UIColor.black
        l.numberOfLines = 0
        return l
    }()
    private lazy var view: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.6)
        
        v.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        return v
    }()
    
    var isClicked = false
    func clicked(){
        if(isClicked){
            setOff()
        }else{
            setOn()
        }
    }
    func setOn(){
        isClicked = true
        view.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 1)
    }
    func setOff(){
        isClicked = false
        view.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.6)
    }
    
    override func setupLayout() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    
}
