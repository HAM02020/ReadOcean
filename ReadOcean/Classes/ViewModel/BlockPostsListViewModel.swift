//
//  BlockPostsListViewModel.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/17.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import Foundation
import SwiftyJSON
import HandyJSON
class BlockPostsListViewModel{
    
    var category: String = ""
    var blockId: String
    
    var currentPage:Int = 1
    var totalPage:Int = 1
    var posts = [Post]()
    
    init(category: String, blockId:String) {
        self.category = category
        self.blockId = blockId
    }
    
    func getPosts(isLoadMore:Bool,completion:@escaping (_ isSuccess:Bool,_ isNoMoreData: Bool)->()){
        
        if(isLoadMore){
            if(self.currentPage > totalPage){
                //nomoredata
                completion(true,true)
                return
            }
            
        }else{
            self.currentPage = 1
        }
        
        Api.networkManager.MyRequest(.getPosts(category: category, blockId: blockId, pageNum: currentPage)) { (result) in
            switch result{
            case .success(let response):
                let json = JSON(response.data)
                guard let returnDataList = ReturnWithDataList<Post>.deserialize(from: json.dictionaryObject),
                      let totalPage = returnDataList.totalPage,
                      let postArray = returnDataList.dataList
                else {return}
                
                if(isLoadMore){
                    self.posts += postArray
                    

                }else{
                    self.posts.removeAll()
                    self.posts = postArray
                    self.totalPage = totalPage
                }
                
                self.currentPage += 1

                completion(true,false)
            case .failure(let error):
                print(error)
                completion(false,true)
            }
            
        }
        
    }
}
