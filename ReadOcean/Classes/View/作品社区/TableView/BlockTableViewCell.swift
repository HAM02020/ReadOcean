//
//  BlockTableViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/10.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BlockTableViewCell:BaseTableViewCell{
    
    private let coverWidth : CGFloat = 100.0
    private let coverHeight : CGFloat = 135.0
    
    private lazy var view:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 5
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.layer.shadowColor = UIColor.darkGray.cgColor
        v.layer.shadowOpacity = 0.3
        v.layer.shadowRadius = 10
        
        v.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-30)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(coverWidth)
            make.height.equalTo(coverHeight+5)
        }
        //coverView.fixLayer(x: 10, y: -25)
        
        v.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(coverView.snp.right).offset(15)
            make.width.equalTo(screenWidth-15*2-100-15*2)
            make.height.equalTo(20)
        }
        v.addSubview(author)
        author.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.width.equalTo(screenWidth-15*2-100-15*2)
            make.height.equalTo(10)
        }
        v.addSubview(post)
        post.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(author.snp.bottom).offset(5)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        v.addSubview(like)
        like.snp.makeConstraints { (make) in
            make.left.equalTo(post.snp.right).offset(15)
            make.top.equalTo(post.snp.top)
            
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        v.addSubview(introductionView)
        introductionView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(like.snp.bottom).offset(5)
            make.height.equalTo(30)
            make.width.equalTo(screenWidth - coverWidth - 15*4 - 5)
        }
        
        return v
    }()
    
    private lazy var coverView: MGImageView = {
        let v = MGImageView(frame: CGRect(x: 0, y: 0, width: coverWidth, height: coverHeight))
        return v
    }()
    private lazy var titleLabel : UILabel = {
       let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        txt.text = ""
        txt.font = .systemFont(ofSize: 18, weight: .bold)
        txt.textColor = UIColor.black
        txt.textAlignment = .left
        txt.numberOfLines = 0
        return txt
    }()
    
    private lazy var author : UILabel = {
       let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 15))
        txt.text = ""
        txt.font = .systemFont(ofSize: 12)
        txt.textColor = UIColor(hexString: "bfbfbf")
        txt.textAlignment = .left
        txt.numberOfLines = 0
        txt.lineBreakMode = .byTruncatingTail
        return txt
    }()
    private lazy var post: UITextView = {
        let txt = UITextView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        txt.text = ""
        txt.font = .monospacedSystemFont(ofSize: 12, weight: .bold)
        txt.textColor = UIColor.white
        txt.textAlignment = .center
        txt.backgroundColor = UIColor.systemYellow
        txt.adjustsFontForContentSizeCategory = true
        txt.layer.cornerRadius = 10
        txt.textContainer.maximumNumberOfLines = 1
        txt.textContainer.lineBreakMode = .byTruncatingTail
        //使文字垂直居中
        txt.contentOffset = CGPoint (x: 0, y: 8)
        txt.isEditable = false
        txt.isScrollEnabled = false
        
        return txt
    }()
    private lazy var like: UITextView = {
        let txt = UITextView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        txt.text = ""
        txt.font = .monospacedSystemFont(ofSize: 12, weight: .bold)
        txt.textColor = UIColor.white
        txt.textAlignment = .center
        txt.backgroundColor = UIColor.systemGreen
        txt.adjustsFontForContentSizeCategory = true
        txt.layer.cornerRadius = 10
        txt.textContainer.maximumNumberOfLines = 1
        txt.textContainer.lineBreakMode = .byTruncatingTail
        //使文字垂直居中
        txt.contentOffset = CGPoint (x: 0, y: 8)
        txt.isEditable = false
        txt.isScrollEnabled = false
        return txt
    }()
   
    private lazy var introductionView: UILabel = {
        let txt = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth-30-30-100, height: 50))
        txt.text = ""
        txt.font = .systemFont(ofSize: 10)
        txt.textColor = UIColor.darkGray
        txt.textAlignment = .left
        txt.adjustsFontForContentSizeCategory = true
        txt.numberOfLines = 2
        
        return txt
    }()
    
    var viewModel:MyBlock?{
        didSet{
            
            guard
                let viewModel = viewModel,
                let imgUrl = viewModel.img,
                let title = viewModel.title,
                let postNum = viewModel.postNum,
                let likeNum = viewModel.likeNum,
                let authorName = viewModel.author,
                let introduction = viewModel.introduction
                
            else {
                return
            }
            
            coverView.mg_setImage(urlString: imgUrl, placeholderImage: UIImage(named: "placeholder"))
            titleLabel.text = title
            author.text = "作者 "+authorName
            post.text = "评论 \(postNum)"
            like.text = "点赞 \(likeNum)"
            introductionView.text = introduction
        }
    }
    
    
    override func setupLayout() {
        //异步绘制 离屏渲染
        self.layer.drawsAsynchronously = true
        
        //栅格化
        //必须指定分辨率 不然h很模糊
        self.layer.shouldRasterize = true
        //分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        
        
        backgroundColor = UIColor.clear
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.left.right.bottom.equalToSuperview().inset(15)
        }
    }
}
