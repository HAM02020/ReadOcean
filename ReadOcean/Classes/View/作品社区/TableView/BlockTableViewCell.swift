//
//  BlockTableViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/10.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BlockTableViewCell:BaseTableViewCell{
    
    private lazy var view:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 5
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.layer.shadowColor = UIColor.darkGray.cgColor
        v.layer.shadowOpacity = 0.3
        v.layer.shadowRadius = 10
        
        v.addSubview(cover)
        cover.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-30)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        v.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(cover.snp.right).offset(15)
            make.width.equalTo(screenWidth-15*2-100-15*2)
            make.height.equalTo(30)
        }
        v.addSubview(author)
        author.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom)
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
            make.bottom.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
        }
        
        return v
    }()
    private lazy var coverView:UIView = {
        let v = UIView()
        v.layer.shadowOffset = CGSize(width: 2, height: 2)
        v.layer.shadowColor = UIColor.darkGray.cgColor
        v.layer.shadowOpacity = 0.3
        v.layer.shadowRadius = 5
        v.layer.shouldRasterize = true
        
        
        v.addSubview(cover)
        cover.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        return v
    }()
    private lazy var cover: UIImageView = {
        let img = UIImage(named: "placeholder")
        let iconView = UIImageView(image: img )
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        //使阴影不被clipsToBounds影响 导致无法显示
        //iconView.layer.masksToBounds = false
        //使图片被切成圆角
        iconView.layer.cornerRadius = 8
        iconView.layer.borderColor = UIColor.clear.cgColor
        iconView.layer.borderWidth = 0.5
 
        
        return iconView
    }()
    private lazy var titleLabel : UILabel = {
       let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        txt.text = "嫌疑人X的献身"
        txt.font = .systemFont(ofSize: 18, weight: .bold)
        txt.textColor = UIColor.black
        txt.textAlignment = .left
        txt.numberOfLines = 0
        return txt
    }()
    
    private lazy var author : UILabel = {
       let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 15))
        txt.text = "作者 东野圭吾"
        txt.font = .systemFont(ofSize: 12)
        txt.textColor = UIColor(hexString: "bfbfbf")
        txt.textAlignment = .left
        txt.numberOfLines = 0
        txt.lineBreakMode = .byTruncatingTail
        return txt
    }()
    private lazy var post: UITextView = {
        let txt = UITextView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        txt.text = "讨论 2000"
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
        txt.text = "点赞 439"
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
   
    private lazy var introductionView: UITextView = {
        let txt = UITextView(frame: CGRect(x: 0, y: 0, width: screenWidth-30-30-100, height: 50))
        txt.text = "《呼兰河传》共七章，写的是20世纪20年代北方一座普普通通的小城呼兰，以及普普通通的人的普普通通的生活。《呼兰河传》不是为某一个人作传，而是为作者生于斯、长于斯的小城作传"
        txt.font = .systemFont(ofSize: 10)
        txt.textColor = UIColor.darkGray
        txt.textAlignment = .left
        txt.adjustsFontForContentSizeCategory = true
        
        txt.textContainer.maximumNumberOfLines = 2
        txt.textContainer.lineBreakMode = .byTruncatingTail

        txt.isEditable = false
        txt.isScrollEnabled = false
        
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
            
            cover.mg_setImage(urlString: imgUrl , placeholderImage: UIImage(named: "placeholder"))
            titleLabel.text = title
            author.text = "作者 "+authorName
            post.text = "评论 \(postNum)"
            like.text = "点赞 \(likeNum)"
            introductionView.text = introduction
        }
    }
    
    
    override func setupLayout() {
        backgroundColor = UIColor.clear
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.left.right.bottom.equalToSuperview().inset(15)
        }
    }
}
