//
//  ApiByMoya.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/16.
//  Copyright © 2020 HAM02020. All rights reserved.
//
import Moya
import HandyJSON
import SwiftyJSON

//public let HOSTADDRESS = "https://59.38.32.42"
public let HOST_ADDRESS = "https://ro.bnuz.edu.cn"
public let USER_ID : String = "F2F9105E-B6F8-C2A2-279A-A9DF84701F57"
public var USER_TYPE : String = "user_type_student"


let ApiProvider = MoyaProvider<ApiByMoya>(requestClosure: timeoutClosure)

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<ApiByMoya>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

enum ApiByMoya{
    
    //书香门第
    case getBooks(category:String?,pageNum:Int = 1)
    case infoBook(bookId:String)
    //作品社区
    case getBlocks(category:String?,pageNum:Int? = 1)
    
    //我的任务
    case myTask(userId:String,userType:String = USER_TYPE)
    case taskDetail(taskId:String,userId:String = USER_ID,userType:String = USER_TYPE)
    
    case login(schoolId:Int = 1000000,userType:String = USER_TYPE,lat:Int = 1,lng:Int = 1,userName:String,password:String)
}

extension ApiByMoya:TargetType{
    var baseURL: URL {
        return URL(string: "https://ro.bnuz.edu.cn")!
    }
    
    var path: String {
        switch self {
        case .getBlocks:
            return "mobileForum/getBlocks"

        case .getBooks:
            return "mobileBook/getBooks"
        case .infoBook:
            return "mobileBook/infoBook"
        case .myTask:
            return "mobileTask/myTask"
        case .taskDetail:
            return "mobileTask/taskDetail"
        case .login:
            return "mobileUser/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBlocks,.getBooks,.infoBook,.myTask,.taskDetail:
            return .get
        case .login:
            return .post
            
        }
    }
    
    var sampleData: Data {return "".data(using: .utf8)!}
    
    var task: Moya.Task {
        var parmeters: [String : Any] = [:]
        
        switch self {
        case .getBlocks(let category,let pageNum):
            parmeters["category"] = category
            parmeters["pageNum"] = pageNum
        case .getBooks(let category,let pageNum):
            parmeters["category"] = category
            parmeters["pageNum"] = pageNum
        case .infoBook(let bookId):
            parmeters["bookId"] = bookId
        case .myTask(let userId,let userType):
            parmeters["userId"] = userId
            parmeters["userType"] = userType
        case .taskDetail(let taskId,let userId,let userType):
            parmeters["taskId"] = taskId
            parmeters["userId"] = userId
            parmeters["userType"] = userType
        case .login(let schoolId,let userType,let lat,let lng,let userName,let password):
            parmeters["userName"] = userName
            parmeters["password"] = password
            parmeters["schoolId"] = schoolId
            parmeters["userType"] = userType
            parmeters["lat"] = lat
            parmeters["lng"] = lng
            
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        let headers : [String:String] = [:]
        
        return headers
    }
    
  
}


extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let json = JSON(data).dictionaryObject
        guard let model = JSONDeserializer<T>.deserializeFrom(dict: json) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

extension MoyaProvider {
    @discardableResult
    open func requestData<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {
        
        return request(target, completion: { (result) in
            guard let completion = completion else { return }
            switch result {
            case .success(let response):
                guard
                    let returnData = try? response.mapModel(ReturnData<T>.self),
                    let data = returnData.data
                    else {completion(nil);return}
                
                completion(data)
                
            case .failure(_):
                completion(nil)
            }
            
        })
    }
    @discardableResult
    open func requestDataList<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnDataList: [T]?) -> Void)?) -> Cancellable? {
        
        return request(target, completion: { (result) in
            guard let completion = completion else { return }
            switch result {
            case .success(let response):
                guard
                    let returnDataList = try? response.mapModel(ReturnWithDataList<T>.self),
                    let dataList = returnDataList.dataList
                    else {completion(nil);return}

                completion(dataList)
                
            case .failure(_):
                completion(nil)
            }
            
        })
    }
}
