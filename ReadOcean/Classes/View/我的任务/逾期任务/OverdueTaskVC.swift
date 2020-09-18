//
//  OverdueTask.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//
import UIKit
class OverdueTaskVC : BaseTaskVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadData(){
        ProgressHUD.show()
        networkManager.requestDataList(.myTask(user: UserAccount.main, taskType: .overdue()), model: Task.self) {[weak self] (dataList) in
            self?.tableView.myHead.endRefreshing()
            guard let dataList = dataList else {ProgressHUD.showFailed();return}
            var shouldRefresh = false
            for task in dataList{
                if !self!.taskList.contains(where: { (element) -> Bool in
                    return element.id == task.id})
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
