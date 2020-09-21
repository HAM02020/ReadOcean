//
//  YDt5ViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit



class YDt5ViewController : BaseViewController {
    
    var config = [[PModel("profile_green","个人信息")],
                  [PModel("shop_red","海洋书店")],
                  [PModel("report_blue","阅读报告"),PModel("ing_orange","正在阅读"),PModel("finish_green","我已阅读")],
                  [PModel("question_red","我的问答"),PModel("community_blue","我的论坛")],
                  [PModel("feedback_darkblue","意见反馈")]
                ] as [[PModel]]
    let avatarWidth = screenHeight*0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userLogon{
            img_avatar.sd_setImage(with: URL(string: (shardAccount.userInfo?.avatar)!), placeholderImage: nil, options: [], progress: nil) {[weak self] (image, _, _, _) in
                self?.img_avatar.image = image?.reSizeImage(reSize: CGSize(width: screenHeight*0.1, height: screenHeight*0.1))
            }
            
            guard
                let userInfo = shardAccount.userInfo,
                let userName = userInfo.userName,
                let schoolName = userInfo.schoolName,
                let userPoints = userInfo.userPoints,
                let rankTitle = userInfo.rankTitle,
                let rank = userInfo.rank
                else {return}
            nameLabel.text = userName
            schoolLabel.text = schoolName
            levelTextView.text = "Lv\(rank)"
            
            let userPointsLabel = scoreLabelView.arrangedSubviews[1] as! UILabel
            userPointsLabel.text = userPoints
            let rankTitleLabel = rankTitleLabelView.arrangedSubviews[1] as! UILabel
            rankTitleLabel.text = rankTitle
            logoutBtn.isHidden = false
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    lazy var tableView : UITableView = {
        let t = UITableView()
        t.backgroundColor = UIColor(hexString: "f2f2f2")
        t.contentInset = UIEdgeInsets(top: screenHeight/3, left: 0, bottom: 0, right: 0)
        //设置代理
        t.dataSource = self
        t.delegate = self
        //注册cell
        t.register(cellType: ProfileTableViewCell.self)
        //分割线
        t.separatorStyle = .singleLine
        t.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        t.tableFooterView = UIView()
        // 刷新控件
        t.myFoot = URefreshDiscoverFooter()
        return t
    }()
    
    private lazy var navView : HomeNavView = {
        let nav = HomeNavView()
        nav.searchBtnClickClosure {
            print("搜索click")
            let vc = YDDemoViewController()
            vc.view.backgroundColor = UIColor.orange
            vc.hidesBottomBarWhenPushed = true
            
            //self.navigationController?.hidesBarsOnSwipe = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return nav
    }()
    
    private lazy var headerView:UIView = {
        let rectHeight = 64
        let v = UIView()
        //点击手势
        let tap = UITapGestureRecognizer(target:self, action:#selector(loginAction))
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(tap)
        
        v.backgroundColor = UIColor.clear
        v.addSubview(background_img)
        background_img.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-rectHeight/2)
            
        }
        
        v.addSubview(img_avatar)
        img_avatar.snp.makeConstraints { (make) in
            make.centerY.equalTo(v.snp.centerY)
            make.left.equalToSuperview().offset(20)
        }
        
        v.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(img_avatar.snp.centerY).offset(-15)
            make.left.equalTo(img_avatar.snp.right).offset(10)
            
        }
        
        v.addSubview(levelTextView)
        levelTextView.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(20)
            make.left.equalTo(nameLabel.snp.right).offset(10)
            
        }
        v.addSubview(logoutBtn)
        logoutBtn.isHidden = true
        logoutBtn.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.top)
            make.right.equalToSuperview().inset(10)
        }
        v.addSubview(schoolLabel)
        schoolLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(img_avatar.snp.centerY).offset(15)
            make.left.equalTo(nameLabel.snp.left)
        }
        v.addSubview(rect)
        rect.snp.makeConstraints { (make) in
            //make.centerY.equalTo(v.snp.bottom)
            make.centerX.equalTo(v.snp.centerX)
            make.width.equalTo(screenWidth-40)
            make.height.equalTo(rectHeight)
            make.bottom.equalToSuperview()
        }
        return v
        
    }()
    
    
    
    private lazy var background_img:UIImageView = {
        let v = UIImageView(image: UIImage(named: "background"))
        return v
    }()
    
    private lazy var img_avatar:UIImageView = {
        
        var img = UIImage(named: "img_boy")
        img = img?.reSizeImage(reSize: CGSize(width: avatarWidth, height: avatarWidth))
        
        let imgView = UIImageView(image: img)
        imgView.backgroundColor = UIColor(hexString: "f2f2f2")
        
        imgView.layer.cornerRadius = imgView.bounds.width/2
        imgView.layer.borderColor = UIColor.clear.cgColor
        imgView.layer.borderWidth = 0.5
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    private lazy var nameLabel : UILabel = {
       let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        txt.text = "点我登陆"
        txt.font = .systemFont(ofSize: 20, weight: .black)
        txt.textColor = UIColor.black
        txt.textAlignment = .left
        txt.numberOfLines = 0
        return txt
    }()
    
    private lazy var schoolLabel : UILabel = {
       let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 15))
        txt.text = "登陆阅读更精彩"
        txt.font = .systemFont(ofSize: 14)
        txt.textColor = UIColor.darkGray
        txt.textAlignment = .left
        txt.numberOfLines = 0
        return txt
    }()
    
    private lazy var logoutBtn:WBTittleButton = {
        let btn = WBTittleButton(title: "退出登陆", image: UIImage())
        btn.imagePosition(style: .left, spacing: 5)
        
        return btn
    }()
    
    private lazy var scoreLabelView : UIStackView = {
       let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 15))
        txt.text = "总积分"
        txt.font = .systemFont(ofSize: 16, weight: .heavy)
        txt.textColor = UIColor.black
        txt.textAlignment = .center
        txt.numberOfLines = 0
        
        
        let num = UILabel(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        num.text = "0"
        num.font = .systemFont(ofSize: 14)
        num.textColor = UIColor.darkGray
        num.textAlignment = .center
        num.numberOfLines = 0
        let starkV = UIStackView()
        starkV.axis = .vertical
        starkV.addArrangedSubview(txt)
        starkV.addArrangedSubview(num)
        return starkV
    }()
    
    private lazy var levelTextView : UITextView = {
        let txt = UITextView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        txt.text = "Lv1"
        txt.font = .monospacedSystemFont(ofSize: 14, weight: .bold)
        txt.textColor = UIColor.white
        txt.textAlignment = .center
        txt.backgroundColor = UIColor.systemYellow
        txt.adjustsFontForContentSizeCategory = true
        txt.layer.cornerRadius = 10
        //使文字垂直居中
        txt.contentOffset = CGPoint (x: 0, y: 8)
        
        
        return txt
    }()
    
    private lazy var rankTitleLabelView : UIStackView = {
       let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 15))
       txt.text = "称号"
       txt.font = .systemFont(ofSize: 16, weight: .heavy)
       txt.textColor = UIColor.black
       txt.textAlignment = .center
       txt.numberOfLines = 0
       
       
       let num = UILabel(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
       num.text = "白丁"
       num.font = .systemFont(ofSize: 14)
       num.textColor = UIColor.darkGray
       num.textAlignment = .center
       num.numberOfLines = 0
       let starkV = UIStackView()
       starkV.axis = .vertical
       starkV.addArrangedSubview(txt)
       starkV.addArrangedSubview(num)
       return starkV
    }()
    
    private lazy var stackView:UIStackView = {
        let stackV = UIStackView()
        stackV.spacing = 0
        stackV.alignment = .center
        stackV.distribution = .fillEqually
        
        stackV.addArrangedSubview(scoreLabelView)
        stackV.addArrangedSubview(rankTitleLabelView)
        
        let line1 = UILabel()
        line1.backgroundColor = UIColor(hexString: "8a8a8a")
        stackV.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.centerX.equalTo((screenWidth-60)/2)
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview().inset(5)
        }
        return stackV
    }()
    
    private lazy var rect:UIView = {
       let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 5
        v.layer.borderColor = UIColor.clear.cgColor
        v.layer.borderWidth = 0.5
        
        v.layer.shadowColor = UIColor.darkGray.cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.layer.shadowOpacity = 0.3
        v.layer.shadowRadius = 5
        
        v.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        return v
    }()
    
    
    


    
    override func setupLayout(){
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-tabbarHeight!)
        }
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(tableView.contentInset.top)
        }
        
//        view.addSubview(navView)
//        navView.snp.makeConstraints { (make) in
//            make.left.top.right.equalToSuperview()
//            make.height.equalTo(88)
//        }
    }
}

extension YDt5ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return config.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return config[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProfileTableViewCell.self)
        cell.viewModel = config[indexPath.section][indexPath.row]
        return cell
    }
    
    
    
    
    //使头部视图滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navView.value = scrollView.contentOffset.y
        print("contentoffset.y = \(scrollView.contentOffset.y)")
        print("contentInset.top = \(scrollView.contentInset.top)")
        print("和 = \(scrollView.contentOffset.y + scrollView.contentInset.top)\n")
        //setNeedsStatusBarAppearanceUpdate()
        
        if scrollView == scrollView {
            headerView.snp.updateConstraints{ $0.top.equalToSuperview().offset(min(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))) }
        }
    }
    
    
}
