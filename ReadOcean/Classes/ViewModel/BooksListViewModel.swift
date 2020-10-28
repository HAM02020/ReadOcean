//
//  BooksListViewModel.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/16.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BooksListViewModel{
    let categoryName = [ "优美诗歌","自然","绘本","童话故事","神话传奇","文史","数学","小说散文","世界名著","名人传记"]
    let categoriesParams = ["category_shige","category_kexue","category_manhua","category_tonghua","category_shenhua","category_lishi","category_shuxue","category_xiaoshuo","category_mingzhu","category_mingren"]
    let maxCellNum = 8
    
    var dataDict = [String:[Book]]()
    
    var pageNums = [String:Int]()
    
    init() {
        //为了loadingCover 添加假数据
        var bookList = [Book]()
        for _ in 0..<8{
            bookList.append(Book())
        }
        self.dataDict["category_shige"] = bookList
        self.dataDict["category_kexue"] = bookList
        self.dataDict["category_manhua"] = bookList
    }
    
    static let shared:BooksListViewModel = {
        let instanse = BooksListViewModel()
        
        return instanse
    }()
    
    
    
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
                    self?.pageNums[category] = 2
                    group.leave()
                }
                
                
            }
            
        }
        group.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
    func getBooksByCategory(category:String, completion:@escaping()->Void){
        networkManager.requestDataList(.getBooks(category: category, pageNum: pageNums[category]!), model: Book.self) { (modelList) in
            
            guard let modelList = modelList else {return}
            
            let group = DispatchGroup()
            
            var bookList = [Book]()
            
            for book in modelList{
                group.enter()
                guard let bookId = book.id else{return}
                networkManager.requestData(.infoBook(bookId: bookId), model: Book.self) { (model) in
                    guard let model = model else {return}
                    bookList.append(model)
                    group.leave()
                }
               
            }
            group.notify(queue: DispatchQueue.main) {[weak self] in
                self?.dataDict[category] = self!.dataDict[category]! + bookList
                self?.pageNums[category]! += 1
                completion()
            }
        }
    }
    
}
