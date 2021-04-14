//
//  YDTaskDetailViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/12.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit

class YDTaskDetailViewController: BaseViewController{
    
    var taskId: String?
    var taskName: String?
    @IBOutlet weak var taskNameLabel: UILabel?
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var isDoneButton: UIButton!
    @IBOutlet weak var hasCommentButton: UIButton!
    
    @IBOutlet weak var bookCoverImage: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func setupLayout() {
        view.backgroundColor = UIColor.white
    }

    @objc func loadData(){
        guard let taskId = taskId else {return}
        networkManager.requestModel(.taskDetail(taskId: taskId), model: Task.self) { (model) in
            guard let model = model,
                  let publisher = model.publisher,
                  let isDone = model.isDone,
                  let hasComment = model.hasComment,
                  let startDate = model.startDate,
                  let endDate = model.endDate,
                  let description = model.description,
                  let books = model.taskBooks
            else {return}
            
            let dateformat = DateFormatter()
            dateformat.dateFormat = "yyyy-MM-dd"
            
            self.publisherLabel.text = publisher
            self.startTimeLabel.text = dateformat.string(from: Date(timeIntervalSince1970: startDate/1000))
            self.endTimeLabel.text = dateformat.string(from: Date(timeIntervalSince1970: endDate/1000))
            self.descLabel.text = description
            self.isDoneButton.setTitle(isDone ? "已完成":"未完成", for: .normal)
            self.hasCommentButton.setTitle(hasComment ? "已评价":"未评价", for: .normal)
            self.bookCoverImage.mg_setImage(urlString: books[0].coverImg, placeholderImage: nil)
            self.bookNameLabel.text = books[0].title ?? ""
        }
    }
}
