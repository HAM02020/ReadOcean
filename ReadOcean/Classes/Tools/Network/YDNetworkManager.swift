//
//  YDNetworkManager.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/6/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
enum HTTPMethod {
    case GET
    case POST
}

class YDNetworkManager : AFHTTPSessionManager{
    
    //static let shared = { ()-> YDNetworkManager in可以这么写 用闭包
    static let shared : YDNetworkManager = {
        let instance = YDNetworkManager()
        //是否允许无效证书
        instance.securityPolicy.allowInvalidCertificates = true
        //是否校验域名
        instance.securityPolicy.validatesDomainName = false
   
        
//        instance.requestSerializer = AFJSONRequestSerializer.init()
//        instance.responseSerializer = AFJSONResponseSerializer.init()
        instance.responseSerializer.acceptableContentTypes?.insert("application/json;charset=UTF-8")
        instance.requestSerializer.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return instance
    }()
    /// 使用一个函数封装 GET POST
       /// - Parameters:
       ///   - method: GET/POST
       ///   - URLString: URLString
       ///   - parameters: 参数字典
       ///   - completion: 完成回调[json(字典/数组),是否成功]
       func request(method:HTTPMethod = .GET,URLString:String,parameters:[String:AnyObject],completion:@escaping( _ json:AnyObject?,_ isSuccess:Bool)->()) {
        
            guard let vc = topVC else {
                return
            }
            MBProgressHUD.hide(for: vc.view, animated: false)
            MBProgressHUD.showAdded(to: vc.view, animated: true)
           // 成功回调
           let success = {(task:URLSessionDataTask,json:Any?)->() in
                MBProgressHUD.hide(for: vc.view, animated: true)
                completion(json as AnyObject?,true)
           }
           
           //失败回调
           let failure = {(task:URLSessionDataTask?,error:Error)->() in
               
               //针对403 token过期 做处理
               if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                   print("403")

               }
               
               print("网络请求错误\(error)")
               completion(nil,false)
           }
           
           if method == .GET {
            get(URLString, parameters: parameters, headers: nil, progress: nil, success: success, failure: failure)
           }else {
            post(URLString, parameters: parameters, headers: nil, progress: nil, success: success, failure: failure)
           }
    
       }
    
}
