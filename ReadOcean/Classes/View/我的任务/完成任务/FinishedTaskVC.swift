//
//  FinishedTaskVC.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//
import UIKit
class FinishedTaskVC : BaseTaskVC {

    override func loadData(){
        if #available(iOS 13.0, *) {
            ProgressHUD.show()
        } else {
            // Fallback on earlier versions
        }
        networkManager.requestDataList(.myTask(user: shardAccount, taskType: .none()), model: Task.self) {[weak self] (dataList) in

            self?.tableView.myHead.endRefreshing()
            guard let dataList = dataList else {if #available(iOS 13.0, *) {
                ProgressHUD.showFailed()
            } else {
                // Fallback on earlier versions
            };return}

            //已完成任务的列表
            var doneList:[Task] = []
            for task in dataList{
                if task.isDone!{
                    doneList.append(task)
                }
            }
            //判断是否需要刷新
            var shouldRefresh = false
            for done in doneList{
                let isContain = self!.taskList.contains(where: { (element) -> Bool in
                    return element.id == done.id
                })
                if !isContain
                {
                    shouldRefresh = true
                    break
                }
            }
            if shouldRefresh {
                self?.taskList += doneList
                self?.tableView.reloadData()
            }
            if #available(iOS 13.0, *) {
                ProgressHUD.showSucceed()
            } else {
                // Fallback on earlier versions
            }
        }

        
        
    }
}
