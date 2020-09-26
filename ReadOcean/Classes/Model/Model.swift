//
//  YDBook.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/6/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import HandyJSON

struct UserInfo:HandyJSON{
    var gender:String?//": "女",
    var idCard:String?//": "123123",
    var schoolType:String?//": "1",
    var className : String?//": "广东班",
    var availablePoints:Int?//": 210,
    var avatar : String?//": "http://ro.bnuz.edu.cn/user/default/img_girl.png",
    var rankTitle:String?//": "儒生",
    var userName:String?//": "学生甲",
    var classId:String?//": "40d7c708-ca49-409f-8419-91287efaea36",
    var userPoints:String?//": "500",
    var grade:String?//": "二年级",
    var schoolId:String?//": "1000000",
    var rank:String?//": "2",
    var schoolName:String?//": "阅读海洋小学"
}

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
struct MyBlock {
    var img:String?
    //讨论
    var postNum:Int?
    //点赞
    var likeNum:Int?
    var title:String?
    var blockId:String?
    var bookId:String?
    var author:String?
    var introduction:String?
}

enum TaskType{
    case none(_ rawValue:String = "")
    case done(_ rawValue:String = "done")
    case pending(_ rawValue:String = "pending")
    case overdue(_ rawValue:String = "overdue")
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

