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
            //合并字典
            if let parameters = parameters{
                for e in parameters{
                    params[e.key] = parameters[e.key]
                }
            }
            
            
        case .taskDetail:
            url = url + "/mobileTask/taskDetail"
            params["userId"] = userId as AnyObject
            params["userType"] = userType as AnyObject
            //params["taskId"] = "taskId" as AnyObject
            if let parameters = parameters{
                for e in parameters{
                    params[e.key] = parameters[e.key]
                }
            }
        
        
        }
        YDNetworkManager.shared.request(URLString: url, parameters: params) { (json, _) in completion(json)}
    }
}
