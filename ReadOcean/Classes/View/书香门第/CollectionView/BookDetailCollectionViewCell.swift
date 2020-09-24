//
//  BookDetailCollectionViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/16.
//  Copyright © 2020 HAM02020. All rights reserved.
//
import UIKit

class BookDetailCollectionViewCell:BaseCollectionViewCell{
    
    let bgColors = ["e5ebfa","ffede8","f2f4de","e5f8ed"]
    

    private lazy var view:UIView = {
        let v = UIView()
        let random = Int(arc4random() % 4)
        v.backgroundColor = UIColor(hexString: bgColors[random])
        v.layer.cornerRadius = 5
//        v.layer.shadowOffset = CGSize(width: 0, height: 2)
//        v.layer.shadowColor = UIColor.darkGray.cgColor
//        v.layer.shadowOpacity = 0.3
//        v.layer.shadowRadius = 10
        
        v.addSubview(cover)
        cover.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(-20)
            make.width.equalTo(80)
            
        }
        v.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(cover.snp.right).offset(15)
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
        
        v.addSubview(introductionView)
        introductionView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(author.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
        }
        
        return v
    }()

    lazy var cover: UIImageView = {
        let img = UIImage(named: "placeholder")
        let iconView = UIImageView(image: img )
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        //使阴影不被clipsToBounds影响 导致无法显示
        //iconView.layer.masksToBounds = false
        //使图片被切成圆角
        iconView.layer.cornerRadius = 5
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
    
   
    private lazy var introductionView: UILabel = {
        let txt = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth-30-30-100, height: 50))
        txt.text = "《呼兰河传》共七章，写的是20世纪20年代北方一座普普通通的小城呼兰，以及普普通通的人的普普通通的生活。《呼兰河传》不是为某一个人作传，而是为作者生于斯、长于斯的小城作传"
        txt.font = .systemFont(ofSize: 10)
        txt.textColor = UIColor.darkGray
        txt.textAlignment = .left
        txt.adjustsFontForContentSizeCategory = true
        
        txt.numberOfLines = 2
        
        return txt
    }()
    
     var viewModel:Book?{
        didSet{
            
            guard
                let viewModel = viewModel,
                let imgUrl = viewModel.picUrl,
                let title = viewModel.name,
                let authorName = viewModel.author,
                let introduction = viewModel.introduction
                
            else {
                return
            }
            
            //cover.mg_setImage(urlString: imgUrl , placeholderImage: UIImage(named: "placeholder"))
            titleLabel.text = title
            author.text = "作者 "+authorName
            introductionView.text = introduction
        }
    }
    
    
    override func setupLayout() {

        backgroundColor = UIColor.clear
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    func updateTableViewCell(){
        //view.backgroundColor = UIColor.white
        view.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
            
        }
        cover.snp.updateConstraints { (make) in
            make.top.equalToSuperview()
        }
    }
}

