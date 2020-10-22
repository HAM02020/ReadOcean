//
//  BookDetailCourseTableViewCell.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/10/22.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BookDetailCourseTableViewCell:BaseTableViewCell{
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addDashdeBorderLayer(by: contentView)
    }
    
    lazy var label: UILabel = {
        let txt = UILabel()
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textColor = UIColor.black
        return txt
    }()
    
    var course: Course?{
        didSet{
            guard let course = course,
                  let title = course.title,
                  let author = course.author
                  else {return}
            label.text = "《\(title)》-- \(author)"
        }
    }
    
    override func setupLayout() {
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
}
