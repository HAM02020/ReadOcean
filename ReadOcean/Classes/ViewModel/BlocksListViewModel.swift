//
//  BlocksListViewModel.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/11.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

enum MyRreshState {
    case isRefreshing
    case didRefresh
    case shouldRefresh
    case shouldEndRefresh
}

class BlocksListViewModel{
    

    

    var pageNum = 1
    var noMoreData = false
    var category = ""
    var loadCount = 0
    lazy var blockList:[Block] = []
    lazy var bookList:[Book] = []
    lazy var myBlockList:[MyBlock] = []
    
    init() {
        for _ in 1...4{
            myBlockList.append(MyBlock())
        }
    }
    
    var shouldComplete = false
    
    func loadData(isFirstLoad:Bool=false,isPullup:Bool,completion:@escaping(_ noMoreData:Bool)->Void){
        let myQueue = DispatchQueue(label: "myQueue")
        let group = DispatchGroup()

        //当进行下拉刷新时 重置pageNum和noMoreData
        if !isPullup {
            pageNum = 1
            noMoreData = false
            myBlockList.removeAll()
            bookList.removeAll()
            blockList.removeAll()
        }
        
        myQueue.async { [self] in
            for _ in 0..<5 {
                group.enter()
                self.loadMyBlocks{
                    self.loadCount += 1
                    self.pageNum += 1
                    group.leave()
                }

                group.wait()

                if self.myBlockList.count >= 4+4{
                    print("break")
                    break
                }
            }
            DispatchQueue.main.async {
                if isFirstLoad {
                    myBlockList.removeSubrange(0..<4)
                }
                print("loadCount = \(loadCount)")
                print("myBlockListCount = \(myBlockList.count)")
                completion(self.noMoreData)
            }
            
        }

    }
    
    func loadMyBlocks(isFirstLoad:Bool = false,_ completion:@escaping()->Void){

        
        
        getBlocks{[weak self] in
            self?.getMyBlocks(){
                 
                completion()
            }
            
        }

        

                    
    }
    
    func getBlocks(_ completion:@escaping()->Void){
        
        networkManager.requestDataList(.getBlocks(category: category, pageNum: pageNum), model: Block.self) {[weak self] (modelList) in
            
            guard let modelList = modelList else {return}
            
            if modelList.count == 0{
                self?.noMoreData = true
            }
            

            self?.blockList = self!.blockList + modelList
            
            
            completion()
        }
    }
    
    func getBooks(_ completion:@escaping()->Void){
        
        networkManager.requestDataList(.getBooks(category: category, pageNum: pageNum), model: Book.self) {[weak self] (dataList) in
            
            guard let dataList = dataList else{return}
            
            if dataList.count == 0{
                self?.noMoreData = true
            }
            
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

            self?.bookList = self!.bookList + list

                completion()
            }
        }

            
    }
    func getbookById(bookId:String,_ completion:@escaping(_ book:Book)->()){
        
        networkManager.requestData(.infoBook(bookId: bookId), model: Book.self) {(model) in
            
            guard let model = model else{return}
            
            completion(model)
            
        }
    }
    func getMyBlocks(_ completion:@escaping()->Void){
        
        getBooks(){[weak self] in
            
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
            self?.myBlockList = self!.myBlockList  + list
            completion()
        }
        
        
        
    }
    
    
}
