//
//  T3MenuView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/11/16.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class T3MenuView: UIView{
    
    private var numOfItems = 0
    private var names = [String]()
    private var btns = [UIButton]()
    public var hl_color: UIColor = UIColor.systemBlue
    public var delegate:T3MenuViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(numOfItems:Int, names:[String]){
        self.init(frame: CGRect.zero)
        
        self.numOfItems = numOfItems
        self.names = names
        for name in names{
            let btn = UIButton()
            btn.setTitle(name, for: .normal)
            btn.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
            btns.append(btn)
        }
        click(sender: btns[0])
        setupLayout()
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var stackV: UIStackView = {
        let stackV = UIStackView();
        stackV.axis = .horizontal
        stackV.alignment = .center
        stackV.distribution = .fillEqually
        stackV.spacing = 10
        return stackV
    }()
    
    func setupLayout(){
        backgroundColor = UIColor.red
        for btn in btns{
            stackV.addArrangedSubview(btn)
        }
        addSubview(stackV)
        stackV.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(50)
        }
        
    }
    
    func resetButton(){
        for btn in btns{
            btn.backgroundColor = YDColor.backgroundLight
            btn.setTitleColor(UIColor.black, for: .normal)
        }
    }
    func focus(button:UIButton){
        button.backgroundColor = hl_color
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    @objc func click(sender:UIButton){
        resetButton()
        focus(button: sender)
        
        guard let delegate = delegate,
              let title = sender.title(for: .normal) else {return}
        delegate.menuView(buttonDidClick: title)
    }
}



protocol T3MenuViewDelegate {
    func menuView(buttonDidClick  title:String)
}
