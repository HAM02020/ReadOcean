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



let networkManager = MoyaProvider<Api>(requestClosure: timeoutClosure)

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<Api>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

enum Api{
    
    //书香门第
    case getBooks(category:String?,pageNum:Int = 1)
    case infoBook(bookId:String)
    //作品社区
    case getBlocks(category:String?,pageNum:Int? = 1)
    
    //我的任务
    case myTask(user:UserAccount = shardAccount,taskType:TaskType = .none())
    case taskDetail(taskId:String,user:UserAccount = shardAccount)
    
    case login(userName:String,password:String)
    case userInfo(user:UserAccount = shardAccount)
}

extension Api:TargetType{
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
        case .userInfo:
            return "mobileUser/userInfo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBlocks,.getBooks,.infoBook,.myTask,.taskDetail,.userInfo:
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
        case .myTask(let user,let taskType):
            parmeters["userId"] = user.userId
            parmeters["userType"] = user.userType
            switch taskType {
            case .done(let rawValue):
                parmeters["type"] = rawValue
            case .pending(let rawValue):
                parmeters["type"] = rawValue
            case .overdue(let rawValue):
                parmeters["type"] = rawValue
            case .none(_):
                break
            }
        case .taskDetail(let taskId,let user):
            parmeters["taskId"] = taskId
            parmeters["userId"] = user.userId
            parmeters["userType"] = user.userType
        case .login(let userName,let password):
            let user = shardAccount
            parmeters["userName"] = userName
            parmeters["password"] = password
            parmeters["schoolId"] = user.schoolId
            parmeters["userType"] = user.userType
            parmeters["lat"] = user.lat
            parmeters["lng"] = user.lng
            
        case .userInfo(let user):
            parmeters["userId"] = user.userId
            parmeters["userType"] = user.userType
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
