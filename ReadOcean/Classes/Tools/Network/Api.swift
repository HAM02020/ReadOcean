//
//  Api.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/1.
//  Copyright © 2020 HAM02020. All rights reserved.
//

enum RequestType{
    
    //书香门第
    case getBooks
    case infoBook
    //作品社区
    case getBlocks
    
    //我的任务
    case myTask
    case taskDetail
    
    case login
    
}
class Api {
    class func request(_ method:HTTPMethod = .GET, requestType:RequestType,parameters:[String:AnyObject]?,completion:@escaping(_ json:AnyObject?,_ isSuccess:Bool)->()){
        var url  = ""
        var params:[String:AnyObject] = [:]
        switch requestType {
        //我的任务
        case .myTask:
            url = "/mobileTask/myTask"
            params["userId"] = USER_ID as AnyObject
            params["userType"] = USER_TYPE as AnyObject
            
        case .taskDetail:
            url = "/mobileTask/taskDetail"
            params["userId"] = USER_ID as AnyObject
            params["userType"] = USER_TYPE as AnyObject
            //params["taskId"] = "taskId" as AnyObject

        case .getBlocks:
            url = "/mobileForum/getBlocks"
            params["category"] = "category_shige" as AnyObject
            params["pageNum"] = 1 as AnyObject
        case .getBooks:
            url = "/mobileBook/getBooks"
            params["category"] = "category_shige" as AnyObject
            params["pageNum"] = 1 as AnyObject
        case .infoBook:
            url = "/mobileBook/infoBook"
            params["bookId"] = "" as AnyObject
        case .login:
            url = "/mobileUser/login"
            params["schoolId"] = 1000000 as AnyObject
            params["userType"] = USER_TYPE as AnyObject
            params["lat"] = 1 as AnyObject
            params["lng"] = 1 as AnyObject
        }
        
        url = HOST_ADDRESS + url
        params = complieParams(params,parameters)
        
        YDNetworkManager.shared.request(method: method, URLString: url, parameters: params) { (json, isSuccess) in completion(json,isSuccess)}
        

        
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
