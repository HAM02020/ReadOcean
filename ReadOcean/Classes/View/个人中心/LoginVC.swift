//
//  LoginVC.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/13.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginVC:BaseViewController{
    
    
    
    
    
    let txtColor = UIColor(hexString: "999999")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let edgeGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(back))
        edgeGes.edges = .left
        view.addGestureRecognizer(edgeGes)
    }
    
    //MARK: - 变量声明区Start
    
    //MARK: 返回按钮
    private lazy var dissmissBtn:UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "dismiss")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    }()
    //MARK: 标题
    private lazy var lab1:UILabel = {
        let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        txt.text = "北京师范大学微课教学研究中心"
        txt.font = .systemFont(ofSize: 14, weight: .semibold)
        txt.textColor = txtColor
        txt.textAlignment = .center
        txt.numberOfLines = 0
        
        return txt
    }()
    private lazy var lab2:UILabel = {
        let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        txt.text = "阅读海洋"
        if #available(iOS 13.0, *) {
            txt.font = .monospacedSystemFont(ofSize: 30, weight: .bold)
        } else {
            // Fallback on earlier versions
        }
        txt.textColor = UIColor.darkGray
        txt.textAlignment = .center
        txt.numberOfLines = 0
        
        return txt
    }()
    //MARK: 用户类型按钮
    private lazy var userTypeBtn:UIButton = {
        let btn = UIButton()
        btn.addSubview(avatarView)
        avatarView.snp.makeConstraints { (make) in
            make.centerX.equalTo(btn.snp.centerX)
            make.top.equalToSuperview()
        }
        
        btn.addSubview(userTypeLabel)
        userTypeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(btn.snp.centerX)
            make.top.equalTo(avatarView.snp.bottom)
        }
        btn.addTarget(self, action:#selector(changeUserType) , for: .touchUpInside)
        return btn
    }()
    
    
    
    private lazy var avatarView:UIImageView = {

        var img = UIImage(named: "avatar_student")
        let imgView = UIImageView(image: img)
        
        imgView.backgroundColor = UIColor(hexString: "f2f2f2")
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = (img?.size.height)!/2

        
        return imgView
    }()
    
    private lazy var userTypeLabel:UILabel = {
        let txt = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        txt.text = "学生"
        txt.font = .systemFont(ofSize: 14, weight: .bold)
        txt.textColor = txtColor
        txt.textAlignment = .center
        txt.numberOfLines = 0
        
        return txt
    }()
    
//    private lazy var pickerView:UIPickerView = {
//        
//    }()
    
    
    private lazy var userNameField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "用户名"
        tf.textColor = UIColor.darkGray
        tf.returnKeyType = .next
        tf.delegate = self
        
        return tf
    }()
    private lazy var passwordField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入密码"
        tf.textColor = UIColor.darkGray
        tf.isSecureTextEntry = true
        tf.returnKeyType = .done
        tf.delegate = self
        return tf
    }()
    
    private lazy var userInputView:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 5

        
        v.layer.shadowColor = UIColor.darkGray.cgColor
        v.layer.shadowOffset = CGSize(width: 1, height: 1)
        v.layer.shadowOpacity = 0.3
        v.layer.shadowRadius = 5
        
        v.addSubview(userInputStackView)
        userInputStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(15)
        }
        return v
    }()
    
    private lazy var userInputStackView: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .vertical
        stackV.spacing = 0
        stackV.alignment = .leading
        stackV.distribution = .fillProportionally
        
        //stackV.backgroundColor = UIColor.white
        
        stackV.addArrangedSubview(userNameField)
        stackV.addArrangedSubview(passwordField)
        userNameField.snp.makeConstraints { (make) in
            make.width.equalTo(stackV.snp.width)
        }
        passwordField.snp.makeConstraints { (make) in
            make.width.equalTo(stackV.snp.width)
        }
        let line1 = UILabel()
        line1.backgroundColor = txtColor
        stackV.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.centerY.equalTo(stackV.snp.centerY)
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
        }
        
        return stackV
        
    }()
    private lazy var loginBtn : UIButton = {
       let btn = UIButton()
        btn.setTitle("登录", for: [])
        //btn.titleLabel?.textColor = txtColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .black)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor(hexString: bgColor_light)
        //btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        btn.layer.shadowColor = UIColor.darkGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 1, height: 1)
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowRadius = 5
        
        btn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        return btn
    }()
    private lazy var registerBtn : UIButton = {
       let btn = UIButton()
        btn.setTitle("还未有账号？免费注册", for: [])
        btn.setTitleColor(txtColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        return btn
    }()
    private lazy var forgetPwdBtn : UIButton = {
       let btn = UIButton()
        btn.setTitle("忘记密码？", for: [])
        btn.setTitleColor(txtColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        return btn
    }()
    private lazy var threeLoginLabel : UILabel = {
        let txt = UILabel()
        txt.text = "──────  第三方登录  ──────"
        txt.font = .systemFont(ofSize: 14, weight: .semibold)
        txt.textColor = txtColor
        txt.textAlignment = .center
        txt.numberOfLines = 0
        
        return txt
    }()
    private lazy var wechatLogoView:UIImageView = {
        let w:CGFloat = 30.0
        var img = UIImage(named: "wechat_logo")?.resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), resizingMode: .stretch)
        let imgView = UIImageView(image: img)
        
        imgView.backgroundColor = UIColor.white
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 40/2
        
        imgView.layer.borderWidth = 0.5
        imgView.layer.borderColor = UIColor(hexString: "f0f0f0").cgColor
        
        return imgView
    }()
    //MARK: 变量声明区END
    
    
    
    //MARK: - SetupLayout()
    override func setupLayout() {
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(dissmissBtn)
        dissmissBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(navigationExtendHeight/2)
            make.width.height.equalTo(30)
        }
        
        view.addSubview(lab1)
        lab1.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(dissmissBtn.snp.bottom)

        }
        view.addSubview(lab2)
        lab2.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(lab1.snp.bottom).offset(10)

        }
        view.addSubview(userTypeBtn)
        userTypeBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(lab2.snp.bottom).offset(20)
            make.width.height.equalTo(100)
        }
        
        
        view.addSubview(userInputView)
        userInputView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(userTypeBtn.snp.bottom).offset(20)
            make.height.equalTo(100)
            make.width.equalToSuperview().inset(20)
        }
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(userInputView.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(20)
        }
        view.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(loginBtn.snp.left)
            make.top.equalTo(loginBtn.snp.bottom).offset(20)
            make.height.equalTo(20)
            make.width.lessThanOrEqualTo(200)
        }
        view.addSubview(forgetPwdBtn)
        forgetPwdBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(registerBtn.snp.centerY)
            make.right.equalTo(loginBtn.snp.right)
            make.height.equalTo(20)
            make.width.lessThanOrEqualTo(100)
        }
        view.addSubview(threeLoginLabel)
        threeLoginLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalToSuperview().offset(-80)
        }
        view.addSubview(wechatLogoView)
            wechatLogoView.snp.makeConstraints { (make) in
                make.centerX.equalTo(view.snp.centerX)
                make.top.equalTo(threeLoginLabel.snp.bottom).offset(10)
                make.width.height.equalTo(40)
            }

        
        
    }
    
}

//MARK: - UITextFieldDelegate
extension LoginVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.isEqual(userNameField)){
            passwordField.becomeFirstResponder()
        }
        else{
            passwordField.resignFirstResponder()
            userNameField.resignFirstResponder()
            loginBtnClick()
        }
        return true
    }
    
}


//MARK: - OBJC Function
extension LoginVC{

    /// 返回上级页面
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    ///登陆按钮CLick
    @objc func loginBtnClick(){
        guard
            let userName = userNameField.text,
            let password = passwordField.text else {return}
        networkManager.request(.login(userName: userName, password: password)) {[weak self] (result) in
            switch result {
            case .success(let response):
                
                guard
                    let json = JSON(response.data).dictionaryObject,
                    let token = json["token"] ,
                    let userId = json["userId"]
                    else {
                        //登陆失败
                    if #available(iOS 13.0, *) {
                        ProgressHUD.showError("登陆失败，用户名或密码错误", image: nil, interaction: true)
                    } else {
                        // Fallback on earlier versions
                    }
                        return
                }
                shardAccount.userId = userId as! String
                shardAccount.token = token as? String
                //登陆成功通知
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YDUserLoginSuccessNotification), object: nil)
                if #available(iOS 13.0, *) {
                    ProgressHUD.showSucceed()
                } else {
                    // Fallback on earlier versions
                }
                self?.back()
                
            case .failure(_):
                break
            }
        }
             
    }
    
    @objc func changeUserType(){
        UIView.transition(with: self.avatarView, duration: 0.6, options: .transitionFlipFromLeft, animations: {
            guard let img = self.avatarView.image else {return}
            self.avatarView.image =  img.isEqual(UIImage(named: "avatar_student")) ? UIImage(named: "avatar_teacher") : UIImage(named: "avatar_student")
        }, completion: nil)
        UIView.transition(with: self.userTypeLabel, duration: 0.6, options: .transitionFlipFromLeft, animations: {
            self.userTypeLabel.text = self.userTypeLabel.text == "学生" ? "老师" : "学生"
        }, completion: nil)
        
    }
}
