//
//  YDBook.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/6/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import HandyJSON


struct Book : HandyJSON {
    var id:String?
    var name:String?
    var picUrl:String?
    var author:String?
    
    var introduction:String?
    var recommend:String?
    var pages:Int?
    var categoryId:String?
    var publishingHouse:String?
    var remark:String?
    var category:String?
    var topicId:String?
}

struct Block:HandyJSON {
    var img:String?
    //讨论
    var postNum:Int?
    //点赞
    var likeNum:Int?
    var title:String?
    var id:String?
}
struct Task:HandyJSON{
    
    var id:String?
    var startDate: TimeInterval?
    var endDate: TimeInterval?
    var title: String?
    var publisher: String?
    var isDone: Bool?
    var hasComment: Bool?

    
}
struct ReturnData<T: HandyJSON>: HandyJSON {
    var result:String?
    var data: T?
    var code: Int = 0
}

struct ReturnWithDataList<T: HandyJSON>: HandyJSON{
    var totalPage:Int?
    var dataList:[T]?
    var currentPage:Int = 1
}

