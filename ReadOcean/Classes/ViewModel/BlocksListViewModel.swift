//
//  BlocksListViewModel.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/11.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BlocksListViewModel{
    
    var pageNum = 1
    var totalpage = 1
    var category = ""
    lazy var blockList:[Block] = []
    lazy var bookList:[Book] = []
    lazy var myBlockList:[MyBlock] = []
    
    func loadBlocks(isPullup:Bool,completion:@escaping(_ isSuccess:Bool)->()){


        
        getBlocks(isPullup: isPullup, completion: {[weak self] (isSuccess) in
            self?.getMyBlocks(isPullup: isPullup) {[weak self] (isSuccess) in
                
                
                if isPullup{
                    self?.pageNum += 1
                }else{
                    self?.pageNum = 1
                }
                

                
                
                completion(true)
            }
        })

        

                    
    }
    
    func getBlocks(isPullup:Bool,completion:@escaping(_ isSuccess:Bool)->()){
        Api.request(.getBlocks, parameters: ["category":category,"pageNum":pageNum] as [String:AnyObject]) {[weak self] (json) in
            
            

            guard
                let json = json as? [String:Any],
                let result = ReturnWithDataList<Block>.deserialize(from: json),
                let dataList = result.dataList
            else { return }
            
            if(isPullup){
                self?.blockList = self!.blockList + dataList
            }else{
                self?.blockList = dataList
            }
            
            completion(true)
        }
    }
    
    func getBooks(isPullup:Bool,completion:@escaping(_ isSuccess:Bool)->()){
        
        
        Api.request(.getBooks, parameters: ["category":category,"pageNum":pageNum] as [String:AnyObject]) {[weak self] (json) in
        
            guard
                let json = json as? [String:Any],
                let result = ReturnWithDataList<Book>.deserialize(from: json),
                let dataList = result.dataList
            else { return }
            
            let group = DispatchGroup()
            
            var list:[Book] = []
            
            for data in dataList{
                group.enter()
                guard let bookId = data.id else {return}
                
                self?.getbookById(bookId: bookId) { (book) in

                    list.append(book)
                    group.leave()
                }
                
                
            }
            group.notify(queue: DispatchQueue.main) {
                if(isPullup){
                    self?.bookList = self!.bookList + list
                }else{
                    self?.bookList = list
                }
                completion(true)
            }
        }

            
    }
    func getbookById(bookId:String,completion:@escaping(_ book:Book)->()){
        
        Api.request(.infoBook, parameters: ["bookId":bookId] as [String:AnyObject]) { (json) in
            guard
                let json = json as? [String:Any],
                let result = ReturnData<Book>.deserialize(from: json),
                let model = result.data
            else{return}
            
            completion(model)
            
        }
    }
    func getMyBlocks(isPullup:Bool,completion:@escaping(_ isSuccess:Bool)->()){
        getBooks(isPullup: isPullup,completion: {[weak self] (isSuccess) in

            var list : [MyBlock] = []
            
            for book in self!.bookList{
                
                for block in self!.blockList{
                    if book.name != block.title{
                        continue
                    }
                    var myBlock = MyBlock()
                    myBlock.blockId = block.id
                    myBlock.bookId = book.id
                    myBlock.title = block.title
                    myBlock.img = book.picUrl
                    myBlock.author = book.author
                    myBlock.postNum = block.postNum
                    myBlock.likeNum = block.likeNum
                    myBlock.introduction = book.introduction
                    list.append(myBlock)
                    
                    self?.bookList.removeAll { (item) -> Bool in
                        return item.name == book.name
                    }
                    self?.blockList.removeAll { (item) -> Bool in
                        return item.title == block.title
                    }
                }
                
            }
            if(isPullup){
                self?.myBlockList = self!.myBlockList  + list
            }else{
                
                self?.myBlockList = list
            }
            completion(true)
        })
    }
    
    
}
