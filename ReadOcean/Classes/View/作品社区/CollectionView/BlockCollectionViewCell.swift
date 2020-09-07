//
//  BlockCollectionViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/18.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BlockCollectionViewCell : BaseCollectionViewCell {
    private lazy var cover: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        return iconView
    }()
    private lazy var stackView : UIStackView = {
        let stackV = UIStackView()
        stackV.spacing = 0
        stackV.alignment = .center
        stackV.distribution = .fillEqually
        stackV.spacing = 0
        stackV.axis = .vertical
        return stackV
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.text = "Swift编程从入门到入土"
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    private lazy var postLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.red
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.text = "讨论 2000"
        return titleLabel
    }()
    private lazy var likeLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.red
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.text = "点赞 439"
        return titleLabel
    }()
    
    var viewModel:Block?{
        didSet{
            cover.mg_setImage(urlString: viewModel?.img, placeholderImage: UIImage(named: "placeholder"))
            titleLabel.text = viewModel?.title
            guard let viewModel = viewModel,
                let postNum = viewModel.postNum,
                let likeNum = viewModel.likeNum else {
                return
            }
            postLabel.text = "评论 \(postNum)"
            likeLabel.text = "点赞 \(likeNum)"
        }
    }
    
    override func setupLayout() {
        clipsToBounds = true
        
        addSubview(cover)
        cover.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cover.snp.right).offset(5)
            make.right.equalToSuperview()
            make.centerY.equalTo(snp.centerY)
        }
        addSubview(postLabel)
        postLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalToSuperview()
        }
        addSubview(likeLabel)
        likeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(postLabel.snp.left)
            make.top.equalTo(postLabel.snp.bottom)
            make.right.equalToSuperview()
        }
    }
}
