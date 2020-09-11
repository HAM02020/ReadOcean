//
//  BlockCollectionHeaderView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/18.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

// 回调 相当于 OC中的Block (闭包)
typealias Completion = ()->Void

// 代理
//protocol ComicCollecHeaderViewDelegate: class {
//    func comicCollectionHeaderView(_ comicCHead: BlockCollectionHeaderView, moreAction button: UIButton)
//}

class BlockCollectionHeaderView: BaseCollectionReusableView {
    
    // 代理声明 弱引用
    //weak var delegate: ComicCollecHeaderViewDelegate?
    // 回调声明 相当于 OC中的Block
    private var moreActionClosure: Completion?
    
    lazy var iconView: UIImageView = {
        return UIImageView()
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    lazy var moreButton: UIButton = {
        let mn = UIButton(type: .custom)
        mn.setImage(UIImage(named: "moreBtn"), for: .normal)
        mn.addTarget(self, action: #selector(moreActionClick), for: .touchUpInside)
        return mn
    }()
    
    @objc func moreActionClick(button: UIButton) {
        //delegate?.comicCollectionHeaderView(self, moreAction: button)
        
        guard let closure = moreActionClosure else { return }
        closure()
    }
    
    func moreActionClosure(_ closure: Completion?) {
        moreActionClosure = closure
    }
    
    // 继承父类方法 布局
    override func setupLayout() {
        self.backgroundColor = UIColor(hexString: "f2f2f2")
        
        addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(23)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(5)
            make.centerY.height.equalTo(iconView)
            make.width.equalTo(200)
        }
        
        addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
    }
}
