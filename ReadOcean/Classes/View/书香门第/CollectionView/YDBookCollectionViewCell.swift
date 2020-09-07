//
//  YDBookCollectionViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDBookCollectionViewCell: BaseCollectionViewCell {
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        return iconView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.text = "Swift编程从入门到入土"
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    var viewModel:YDBookViewModel?{
        didSet{
            titleLabel.text = viewModel?.book.name
            iconView.mg_setImage(urlString: viewModel?.book.picUrl, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    
    override func setupLayout(){
        clipsToBounds = true
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
            make.height.equalTo(25)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top)
        }
        iconView.layer.cornerRadius = 5
        iconView.layer.borderColor = UIColor.clear.cgColor
        iconView.layer.borderWidth = 0.5
    }
}
