//
//  Api.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/1.
//  Copyright © 2020 HAM02020. All rights reserved.
//
public let hostAddress = "https://59.38.32.42"
public let userId : String = "F2F9105E-B6F8-C2A2-279A-A9DF84701F57"
public let userType : String = "user_type_student"
enum RequestType{
    
    //书香门第
    case getBooks
    case infoBook
    //作品社区
    case getBlocks
    
    //我的任务
    case myTask
    case taskDetail
    
}
class Api {
    class func request(_ requestType:RequestType,parameters:[String:AnyObject]?,completion:@escaping(_ json:AnyObject?)->()){
        var url = hostAddress
        var params:[String:AnyObject] = [:]
        switch requestType {
        //我的任务
        case .myTask:
            url = url + "/mobileTask/myTask"
            params["userId"] = userId as AnyObject
            params["userType"] = userType as AnyObject
            
        case .taskDetail:
            url = url + "/mobileTask/taskDetail"
            params["userId"] = userId as AnyObject
            params["userType"] = userType as AnyObject
            //params["taskId"] = "taskId" as AnyObject

        case .getBlocks:
            url = url + "/mobileForum/getBlocks"
            params["category"] = "category_shige" as AnyObject
            params["pageNum"] = 1 as AnyObject
        case .getBooks:
            url = url + "/mobileBook/getBooks"
            params["category"] = "category_shige" as AnyObject
            params["pageNum"] = 1 as AnyObject
        case .infoBook:
            url = url + "/mobileBook/infoBook"
            params["bookId"] = "" as AnyObject
        }
        
        params = complieParams(params,parameters)
        
        YDNetworkManager.shared.request(URLString: url, parameters: params) { (json, _) in completion(json)}
        
    }
    
    private static func complieParams(_ p1:[String:AnyObject],_ p2:[String:AnyObject]?)->[String:AnyObject]{
        var temp = p1
        if let p2 = p2{
            for e in p2{
                temp[e.key] = p2[e.key]
            }
            return temp
        }
        return p1
    }
}
