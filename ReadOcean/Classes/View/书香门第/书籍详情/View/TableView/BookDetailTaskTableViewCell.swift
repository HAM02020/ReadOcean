//
//  BookDetailTaskTableViewCel.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/10/22.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BookDetailTaskTableViewCell:BaseTableViewCell{
    
    var record:Record?{
        didSet{
            guard
                let record = record,
                let date = record.date,
                let accuracy = record.accuracy,
                let consume = record.consume else {return}
            let dateFomatter = DateFormatter()
            dateFomatter.dateFormat = "yyyy-MM-dd"
            dateLabel.text = "答题时间："+dateFomatter.string(from: Date(timeIntervalSince1970: date/1000))
            
            correctRate.text = "正确率：\(Int(accuracy*100))%"
            
            timeLabel.text = "用时：\(consume)秒"
        }
    }
    
    
    lazy var dateLabel: UILabel = {
        let txt = UILabel()
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textColor = UIColor.black
        return txt
    }()
    lazy var correctRate: UILabel = {
        let txt = UILabel()
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textColor = UIColor.black
        return txt
    }()
    lazy var timeLabel: UILabel = {
        let txt = UILabel()
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textColor = UIColor.black
        return txt
    }()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addDashdeBorderLayer(by: contentView)
    }
    
    override func setupLayout() {
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(15)
        }
        
        contentView.addSubview(correctRate)
        correctRate.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.height.equalTo(15)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(correctRate.snp.bottom).offset(5)
            make.height.equalTo(15)
        }
        
    }
    
    
    
}


