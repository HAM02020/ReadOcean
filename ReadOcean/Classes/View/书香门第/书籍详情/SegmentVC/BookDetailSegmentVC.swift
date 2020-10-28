//
//  BookDetailSegmentVC.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/9/30.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

let BookDetailTaskTableViewCellId = "BookDetailTaskTableViewCellId"

class BookDetailSegmentVC:BaseViewController,WMZPageProtocol,StoryBoardLoadable{

    
    
    @IBOutlet weak var author: UILabel?
    @IBOutlet weak var publishHouse: UILabel?
    
    @IBOutlet weak var publishDate: UILabel?

    @IBOutlet weak var desc: UILabel?
    
    @IBOutlet weak var EditorChoice: UILabel?
    
    
    @IBOutlet weak var scrollView: UIScrollView?
    
    @IBOutlet weak var tableView: UITableView?{
        didSet{
            tableView?.rowHeight = 60
            tableView?.separatorStyle = .none
            tableView?.register(cellType: BookDetailTaskTableViewCell.self)
            tableView?.register(cellType: BookDetailCourseTableViewCell.self)
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }
    var tableViewType:String = "task"
    
    
    
    
    
    var model:BookDetail?{
        didSet{
            guard let model = model,
                  let date = model.publishDate
                  else {return}
            
            
            
            author?.text = model.author
            publishHouse?.text = model.press
            publishDate?.text =  dateformat.string(from: Date(timeIntervalSince1970: date/1000))
            desc?.text = model.review
            EditorChoice?.text = model.introduction
            
            ///阅读记录
            
        }
    }
    
    class func initFromStoryBoard(id:String,tableViewType:String = "task")->BookDetailSegmentVC{
        let storyboard = UIStoryboard(name: "BookDetailStoryBoard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id) as! BookDetailSegmentVC
        vc.tableViewType = tableViewType
        return vc
    }
    func getMyScrollView()->UIScrollView{

        guard let scrollView = scrollView else{
            guard let tableView = tableView else{
                return UIScrollView()
            }
            return tableView
        }
        return scrollView
    }
    
}

extension BookDetailSegmentVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableViewType {
        case "task":
            return model?.records?.count ?? 0
        case "course":
            
            return model?.courses?.count ?? 0
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableViewType {
        case "task":
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BookDetailTaskTableViewCell.self)
            cell.record = model?.records?[indexPath.row]
            return cell
        case "course":
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BookDetailCourseTableViewCell.self)
            cell.course = model?.courses?[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableViewType {
        case "task":
            return 60
        case "course":
            
            return 30
        default:
            return 0
        }
    }
    
    
    
    
}
