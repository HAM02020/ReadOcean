//
//  YDBlockPublishPostViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/21.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit
import LMJDropdownMenu
class YDBlockPublishPostViewController:BaseViewController{
    
    private lazy var categorysTitle = ["评论","绘画","读后感","读书笔记","思维导图","朗诵","背诵"]
    private lazy var categorysConfig = ["forum_post_pinglun","forum_post_huihua","forum_post_duhougan","forum_post_biji","forum_post_siwei","forum_post_langsong","forum_post_beisong"]
    var selectedCategory: String?
    var blockId:String?
    private lazy var titleInput: UITextField = {
        let v = UITextField()
        v.borderStyle = .roundedRect
        v.placeholder = "请输入标题"
        
        return v
    }()
    private lazy var descInput: UITextView = {
        let v = UITextView()
        v.isScrollEnabled = false
        v.isUserInteractionEnabled = true
        
        return v
    }()
    private lazy var selectImgBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("选择图片", for: UIControl.State())
        btn.setTitleColor(UIColor.darkGray, for: UIControl.State())
        btn.backgroundColor = UIColor.white
        
        btn.addTarget(self, action: #selector(SelectedimageBtnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var imagePicker:UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = .overFullScreen
        imagePicker.delegate = self
        //照片是否可以编辑
        imagePicker.allowsEditing = true
//        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear) {
//            imagePicker.cameraDevice = UIImagePickerController.CameraDevice.rear;
//        } else {
//            imagePicker.cameraDevice = UIImagePickerController.CameraDevice.front;
//        }
//        //跳转到拍照界面或相册
//        self.present(imagePicker, animated: true, completion: nil)
        
        return imagePicker
    }()
    
    private lazy var dropdownMenu:LMJDropdownMenu = {
        let menu = LMJDropdownMenu()
        menu.dataSource = self
        menu.delegate = self
        menu.title = "请选择发布类型"
        menu.titleColor = UIColor.white
        menu.titleBgColor = UIColor.systemBlue
        menu.layer.cornerRadius = 5
        menu.layer.borderWidth = 2
        menu.layer.borderColor = UIColor.white.cgColor
        
        menu.optionLineColor = UIColor.white
        menu.optionLineHeight = 1
        menu.optionBgColor = UIColor.systemBlue
        menu.optionTextColor = UIColor.white
        menu.rotateIcon = UIImage(named: "back")!
        return menu
    }()

    private lazy var imageView:UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "EEEEEE")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发表", style: .plain, target: self, action: #selector(publishBtnClick))
        
        
    }
    func isCategoryAllowUploadImage()->Bool{
        switch selectedCategory {
        case "forum_post_huihua","forum_post_duhougan","forum_post_biji","forum_post_siwei":
            return true
        default:
            return false
        }
    }
    @objc func SelectedimageBtnClick(){
        
        if(!isCategoryAllowUploadImage()){
            ProgressHUD.showFailed("当前类型不允许发表图片", interaction: true)
            return
        }
        
        let alertViewController = UIAlertController(title: "选择照片类型", message: nil, preferredStyle: .actionSheet)

        //如果没有调用addAction方法, 对话框也是会显示的.但是没有可以点击的按钮.
        alertViewController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { action in print("onAction") }))

        //UIAlertAction的第二个参数是 按钮的样式(取消(粗体显示),消极(红色显示),正常)3种样式.
        //第三个参数是一个函数类型的参数. 表示点击按钮之后的调用的方法.

        alertViewController.addAction(UIAlertAction(title: "拍摄", style: .destructive, handler: { action in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
            
        }))
        alertViewController.addAction(UIAlertAction(title: "从手机相册选择", style: .destructive, handler: { action in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            
        }))
        //显示对话框
        self.present(alertViewController, animated: true, completion: nil)
    }
    @objc func publishBtnClick(){
        guard let title = titleInput.text,
              let selectedCategory = selectedCategory,
              let blockId = blockId
              else {
            ProgressHUD.showFailed("请选择发布类型", interaction: true)
            return
        }
        
        BlockPostViewModel.publishPost(category: selectedCategory, blockId: blockId, title: title, description: descInput.text, isImg: true, file: imageView.image?.pngData()) { (isSuccess) in
            
            if(!isSuccess){
                ProgressHUD.showError()
                return
            }
            ProgressHUD.showSucceed()
        }
    }
    
    override func setupLayout() {
        view.addSubview(titleInput)
        titleInput.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.top.equalToSuperview().inset(navHeight + statusBarHeight + 10)
            
        }
        view.addSubview(descInput)
        descInput.snp.makeConstraints { (make) in
            make.top.equalTo(titleInput.snp.bottom).offset(1)
            make.leading.equalTo(titleInput.snp.leading)
            make.trailing.equalTo(titleInput.snp.trailing)
            make.height.equalTo(200)
        }
        view.addSubview(selectImgBtn)
        selectImgBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(titleInput.snp.leading)
            make.top.equalTo(descInput.snp.bottom).offset(10)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
        view.addSubview(dropdownMenu)
        dropdownMenu.snp.makeConstraints { (make) in
            make.trailing.equalTo(titleInput.snp.trailing)
            make.top.equalTo(selectImgBtn.snp.top)
            make.height.equalTo(50)
            make.width.equalTo(180)
        }
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(dropdownMenu.snp.bottom).offset(10)
            make.leading.equalTo(titleInput.snp.leading)
            make.trailing.equalTo(titleInput.snp.trailing)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension YDBlockPublishPostViewController:LMJDropdownMenuDelegate,LMJDropdownMenuDataSource{
    func numberOfOptions(in menu: LMJDropdownMenu) -> UInt {
        return UInt(categorysTitle.count)
    }
    
    func dropdownMenu(_ menu: LMJDropdownMenu, heightForOptionAt index: UInt) -> CGFloat {
        return 50
    }
    
    func dropdownMenu(_ menu: LMJDropdownMenu, titleForOptionAt index: UInt) -> String {
        return categorysTitle[Int(index)]
    }
    func dropdownMenu(_ menu: LMJDropdownMenu, iconForOptionAt index: UInt) -> UIImage {
        return (UIImage(named: "img_boy")?.reSizeImage(reSize: CGSize(width: 15, height: 15)))!
    }
    
    func dropdownMenu(_ menu: LMJDropdownMenu, didSelectOptionAt index: UInt, optionTitle title: String) {
        print("select index = \(index) title = \(title)")
        selectedCategory = categorysConfig[Int(index)]
    }
}

extension YDBlockPublishPostViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image : UIImage!
            if picker.allowsEditing {
                image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            } else {
                image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            }
        dismiss(animated: true) {[weak self] in
            self?.imageView.image = image
            self?.imageView.sizeToFit()
        }
    }
}
