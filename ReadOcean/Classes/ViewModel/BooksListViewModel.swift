//
//  BooksListViewModel.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/16.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BooksListViewModel{
    let categoryName = [ "优美诗歌","绘本","自然","童话故事","神话传奇","文史","数学","小说散文","世界名著","名人传记"]
    let categoriesParams = ["category_shige","category_kexue","category_manhua","category_tonghua","category_shenhua","category_lishi","category_shuxue","category_xiaoshuo","category_mingzhu","category_mingren"]
    let maxCellNum = 8
    
    lazy var dataDict = [String:[Book]]()
    
    func getBooks(completion:@escaping()->Void){
        //调度组
        let group = DispatchGroup()
        
        for category in categoriesParams{
            group.enter()

            networkManager.requestDataList(.getBooks(category: category), model: Book.self) {[weak self] (modelList) in
                guard let modelList = modelList else {return}
                
                let group2 = DispatchGroup()
                
                var bookList = [Book]()
                
                for book in modelList{
                    group2.enter()
                    guard let bookId = book.id else{return}
                    networkManager.requestData(.infoBook(bookId: bookId), model: Book.self) { (model) in
                        guard let model = model else {return}
                        bookList.append(model)
                        group2.leave()
                    }
                   
                }
                group2.notify(queue: DispatchQueue.main) {[weak self] in
                    self?.dataDict[category] = bookList
                    group.leave()
                }
                
                
            }
            
        }
        group.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
        
    
}
