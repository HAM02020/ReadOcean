//
//  File.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class TaskTableViewCell : BaseTableViewCell{
    
    private lazy var view : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.clear.cgColor
        v.layer.cornerRadius = 5
        //阴影
        v.layer.shadowColor = UIColor.darkGray.cgColor
        v.layer.shadowOffset = CGSize(width: 2, height: 2)
        v.layer.shadowOpacity = 0.3
        v.layer.shadowRadius = 5
        return v
    }()
    private lazy var stackView: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .vertical
        stackV.spacing = 5
        stackV.alignment = .lastBaseline
        stackV.distribution = .fillEqually
        return stackV
    }()
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold )
        titleLabel.text = "大家一起来阅读吧"
        titleLabel.numberOfLines = 0
        return titleLabel
        
    }()
    private lazy var commentLabel : UILabel = {
        let commentLabel = UILabel()
        commentLabel.textColor = UIColor.systemYellow
        commentLabel.font = UIFont.systemFont(ofSize: 14)
        commentLabel.text = "评价情况：未评价"
        commentLabel.numberOfLines = 0
        return commentLabel
        
    }()
    private lazy var teacherLabel : UILabel = {
        let teacherLabel = UILabel()
        teacherLabel.textColor = UIColor.black
        teacherLabel.font = UIFont.systemFont(ofSize: 14)
        teacherLabel.text = "发布教师：李老师"
        teacherLabel.numberOfLines = 0
        return teacherLabel
        
    }()
    private lazy var beginTimeLabel : UILabel = {
        let beginTimeLabel = UILabel()
        beginTimeLabel.textColor = UIColor.black
        beginTimeLabel.font = UIFont.systemFont(ofSize: 14)
        beginTimeLabel.text = "开始时间：2019-03-25 12:00"
        beginTimeLabel.numberOfLines = 0
        return beginTimeLabel
        
    }()
    private lazy var endTimeLabel : UILabel = {
        let endTimeLabel = UILabel()
        endTimeLabel.textColor = UIColor.black
        endTimeLabel.font = UIFont.systemFont(ofSize: 14)
        endTimeLabel.text = "结束时间：2020-03-25 12:00"
        endTimeLabel.numberOfLines = 0
        return endTimeLabel
        
    }()
    private lazy var button : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hexString: "0ae6b0")
        btn.setTitle("查看详细", for: .normal)
        btn.tintColor = UIColor.white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14,weight: .bold)
        //设置圆角
        btn.layer.cornerRadius = 3
        return btn
    }()
    
    var viewModel:Task?{
        didSet{
            guard let viewModel = viewModel,
                let title = viewModel.title,
                let hasComment = viewModel.hasComment,
                let publisher = viewModel.publisher,
                let startDate = viewModel.startDate,
                let endDate = viewModel.endDate
            else {
                return
            }
            titleLabel.text = title
            if hasComment{
                commentLabel.textColor = UIColor.systemGreen
                commentLabel.text = "评价情况：已评价"
            }else{
                commentLabel.textColor = UIColor.systemYellow
                commentLabel.text = "评价情况：未评价"
            }
            teacherLabel.text = "发布教师：\(publisher)"
            let dateformat = DateFormatter()
            dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            beginTimeLabel.text =  dateformat.string(from: Date(timeIntervalSince1970: startDate/1000))
            endTimeLabel.text =  dateformat.string(from: Date(timeIntervalSince1970: endDate/1000))
            
            
        }
    }
    override func setupLayout() {
        backgroundColor = UIColor.clear
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(15)
        }
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(commentLabel)
        stackView.addArrangedSubview(teacherLabel)
        stackView.addArrangedSubview(beginTimeLabel)
        stackView.addArrangedSubview(endTimeLabel)
        
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(30)
            make.left.right.equalToSuperview().offset(15)
        }
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(15)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
}
