//
//  TeacherTaskVC.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BaseTaskVC : BaseViewController {

    lazy var taskList:[Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
        view.backgroundColor = .white
    }
    
    lazy var tableView : UITableView = {
        let t = UITableView()
        t.backgroundColor = UIColor.white
        //设置代理
        t.dataSource = self
        t.delegate = self
        //注册cell
        t.register(cellType: TaskTableViewCell.self)
        //去除分割线
        t.separatorStyle = .none
        
        // 刷新控件
        t.myHead = URefreshHeader {self.loadData()}
        t.myFoot = URefreshDiscoverFooter()
        return t
    }()
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(88)
            make.left.right.bottom.equalToSuperview()
        }
    }
    func loadData(){
        ProgressHUD.show()
        Api.networkManager.requestDataList(.myTask(user: UserAccount.shardAccount, taskType: .none()), model: Task.self) {[weak self] (dataList) in
            self?.tableView.myHead.endRefreshing()
            guard let dataList = dataList else {ProgressHUD.showFailed();return}
            var shouldRefresh = false
            for task in dataList{
                if !(self?.taskList.contains(where: { (element) -> Bool in
                    return element.id == task.id}) ?? false)
                {
                    shouldRefresh = true
                    break
                }
            }
            if shouldRefresh{
                self?.taskList += dataList
                self?.tableView.reloadData()
            }
            ProgressHUD.showSucceed()
            
        }
        
        
    }
}
extension BaseTaskVC : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TaskTableViewCell.self)
        cell.viewModel = taskList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let nib = UINib(nibName: "YDTaskDetailViewControllerXib", bundle: nil)
//let vc = nib.instantiate(withOwner: nil, options: nil)[0] as! YDTaskDetailViewController
        
        let vc = YDTaskDetailViewController(nibName: "YDTaskDetailViewControllerXib", bundle: nil)
        vc.taskId = taskList[indexPath.row].id;
        vc.taskName = taskList[indexPath.row].taskTitle ?? ""
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
