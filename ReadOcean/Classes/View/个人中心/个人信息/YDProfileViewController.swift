//
//  YDProfileViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/9.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit

class YDProfileViewController: BaseViewController {

    let keyList:[[String]] = [["userName","gender"],
                   ["schoolName","grade","className","idCard"],
                   ["rankTitle","rank"],
                   ["userPoints","availablePoints"]
                   ]
    let nameList: [[String]] = [["用户名","性别"],
                   ["学校","年纪","班级","学号"],
                   ["称号","等级"],
                   ["积分1","积分2"]
                   ]
        
  /*      gender": "女",
    "idCard": "123111",
    "schoolType": "0",
    "className": "测试班级",
    "availablePoints": 8542,
    "avatar": "a0dbffe7-8f49-4117-895d-7742f259598d.jpg",
    "rankTitle": "进士",
    "userName": "学生甲",
    "classId": "d23385fc-27b8-4657-81b2-1b6010f148cb",
    "userPoints": "8619",
    "grade": "五年级",
    "schoolId": "4404001",
    "rank": "5",
    "schoolName": "珠海香洲第一小学"
    */
    
    private lazy var tableView: UITableView = {
        let t = UITableView(frame: CGRect.zero, style: .insetGrouped)
        t.delegate = self;
        
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func reloadData(){
        
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension YDProfileViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return keyList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyList[section].count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: "YDProfileTableViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: nil, options: nil)[0] as! YDProfileTableViewCell
        cell.titile.text = nameList[indexPath.section][indexPath.row]
        cell.subTitle.text = shardAccount.userInfo?.className
        return cell;
    }
    
    
}
