//
//  YDBook.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/6/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import YYModel
class YDBook : NSObject{
    
    @objc var id:String?
    
    @objc var name:String?
    @objc var picUrl:String?
    @objc var author:String?

    
    ///重写description 的计算型 属性
    override var description: String {
        return yy_modelDescription()
    }
    //类函数 告诉 yy model 遇到数组类型的属性 数组中存放的对象是什么类
    @objc class func modelContainerPropertyGenericClass() -> [String:AnyClass]{
        return ["data":YDBook.self]
    }
}
