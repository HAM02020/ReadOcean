//
//  BookDetailHeaderView.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/10/3.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BookDetailHeaderView:UIView,NibLoadable{
    
    
    @IBOutlet weak var bg: UIImageView!{
        didSet{
            bg.image = bg.image?.imageDarken(withLevel: 0.5)
        }
    }
    @IBOutlet weak var bgView: UIView!{
        didSet{
            bgView.layer.cornerRadius = 10
            bgView.layer.maskedCorners = CACornerMask(rawValue: CACornerMask.layerMinXMinYCorner.rawValue | CACornerMask.layerMaxXMinYCorner.rawValue)
        }
    }
    @IBOutlet weak var cover: UIImageView!{
        didSet{
            cover.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var readedLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var buyBtn: UIButton!{
        didSet{
            buyBtn.addTarget(self, action: #selector(answerQuestion), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var fishLabel: UILabel!
    @IBOutlet weak var tagStackV: UIStackView!
    
    var ansQuestionsBtnClickClosure: (()->Void)?
    
    var viewModel:BookDetail?{
        didSet{
            bg.mg_setImage(urlString: viewModel?.coverImg, placeholderImage: UIImage(named: "placeholder"))
            bg.image = bg.image?.imageDarken(withLevel: 0.5)
            cover.mg_setImage(urlString: viewModel?.coverImg, placeholderImage: UIImage(named: "placeholder"))
            guard
                let viewModel = viewModel,
                let titleText = viewModel.title,
                let readingNum = viewModel.readingNum,
                let readedNum = viewModel.readNum,
                let hasComment = viewModel.hasComment,
                let isDone = viewModel.isDone,
                let hasTask = viewModel.hasTask
                
                //let creatureImg = creature["img"],
                //let isDone = viewModel.isDone
            
            else {return}
           
            titleLabel.text = titleText
            readingLabel.text = "\(readingNum)人正在阅读"
            readedLabel.text = "\(readedNum)人读过"
            commentBtn.setTitle(hasComment ? "已评价" : "未评价", for: UIControl.State())
            buyBtn.setTitle(isDone ? "已完成" : "答题", for: UIControl.State())
            let creature = viewModel.creature
            let creatureName = creature?["name"]
            fishLabel.text = creatureName ?? ""
            
        }
    }
    
    @objc func answerQuestion(){
        guard let ansQuestionsBtnClickClosure = ansQuestionsBtnClickClosure else {return}
        ansQuestionsBtnClickClosure()
    }
}

