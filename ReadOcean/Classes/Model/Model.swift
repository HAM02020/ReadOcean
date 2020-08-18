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

struct ReturnData<T: HandyJSON>: HandyJSON {
    var result:String?
    var data: T?
    var code: Int = 0
}

