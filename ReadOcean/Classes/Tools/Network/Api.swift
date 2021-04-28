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



//let networkManager = MoyaProvider<Api>(requestClosure: timeoutClosure)

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<Api>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 10
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
    
}

enum Api{
    static let networkManager = MoyaProvider<Api>(requestClosure: timeoutClosure)
    //书香门第
    case getBooks(category:String?,pageNum:Int = 1)
    case infoBook(bookId:String)
    case bookDetail(user:UserAccount = UserAccount.shardAccount,bookId:String)
    case bookSearch(keyWord: String = "",pageNum: Int = 1)
    case bookQuestion(bookId:String)
    case commitBookQuestion(bookId:String, detailJson: String, sessionUserId: String = UserAccount.shardAccount.userId)
    //作品社区
    case getBlocks(category:String?,pageNum:Int? = 1)
    case getPosts(category:String,blockId:String,pageNum:Int = 1)
    case publishPost(category: String, blockId: String, userId:String = UserAccount.shardAccount.userId, title: String, description:String, isVoice: String = "true", voiceId:String? = "null", file:Data?)
    //发现
    
    
    //我的任务
    case myTask(user:UserAccount = UserAccount.shardAccount,taskType:TaskType = .none())
    case taskDetail(taskId:String,user:UserAccount = UserAccount.shardAccount)
    
    //个人中心
    case login(userName:String,password:String)
    case userInfo(user:UserAccount = UserAccount.shardAccount)
    case userInfoById(userId:String,userType:String = "user_type_student")
    
}

extension Api:TargetType{
    var baseURL: URL {
        return URL(string: HOST_ADDRESS)!
    }
    var path: String {
        switch self {
        //书香门第
        case .getBooks:
            return "mobileBook/getBooks"
        case .infoBook:
            return "mobileBook/infoBook"
        case .bookDetail:
            return "mobileBook/bookDetail"
        case .bookSearch:
            return "ReadingOcean/mobileBook/search"
        case .bookQuestion:
            return "ReadingOcean/mbookq/answer"
        case .commitBookQuestion:
            return "ReadingOcean/mbookq/detail/add"
        //作品社区
        case .getBlocks:
            return "mobileForum/getBlocks"
        case .getPosts:
            return "mobileForum/getPosts"
        case .publishPost:
            return "ReadingOcean/mobileForum/publish"
        //我的任务
        case .myTask:
            return "mobileTask/myTask"
        case .taskDetail:
            return "mobileTask/taskDetail"
        //个人中心
        case .login:
            return "mobileUser/login"
        case .userInfo:
            return "mobileUser/userInfo"
        case .userInfoById:
            return "mobileUser/userInfo"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getBlocks,.getPosts,.getBooks,.infoBook,.bookDetail,.bookQuestion,.myTask,.taskDetail,.userInfo,.bookSearch,.userInfoById:
            return .get
        case .login, .publishPost, .commitBookQuestion:
            return .post
            
        }
    }
    
    var sampleData: Data {return "".data(using: .utf8)!}
    
    var task: Moya.Task {
        var parmeters: [String : Any] = [:]
        
        switch self {
        
         
        //书香门第
            
        case .getBooks(let category,let pageNum):
            parmeters["category"] = category
            parmeters["pageNum"] = pageNum
        case .infoBook(let bookId):
            parmeters["bookId"] = bookId
        case .bookDetail(let user,let bookId):
            parmeters["userId"] = user.userId
            parmeters["userType"] = user.userType
            parmeters["bookId"] = bookId
            parmeters["schoolId"] = user.schoolId
        case .bookSearch(let keyWord, let pageNum):
            parmeters["keyWord"] = keyWord
            parmeters["pageNum"] = pageNum
            
        case .bookQuestion(let bookId):
            parmeters["bookId"] = bookId
            
        case .commitBookQuestion(let bookId, let detailJson, let sessionUserId):
            parmeters["bookId"] = bookId
            parmeters["detailJson"] = detailJson
            parmeters["sessionUserId"] = sessionUserId
        //作品社区
        
        case .getBlocks(let category,let pageNum):
            parmeters["category"] = category
            parmeters["pageNum"] = pageNum
         
        case .getPosts(let category, let blockId, let pageNum):
            parmeters["category"] = category
            parmeters["blockId"] = blockId
            parmeters["pageNum"] = pageNum
        
        case .publishPost(let category,let blockId, let userId, let title, let description, let isVoice, let voiceId, let file):
            parmeters["category"] = category
            parmeters["blockId"] = blockId
            parmeters["userId"] = userId
            parmeters["title"] = title
            parmeters["description"] = description
            parmeters["isVoice"] = isVoice
            parmeters["voiceId"] = voiceId
            
            if file != nil{
                parmeters["voiceId"] = UUID().uuidString
                parmeters["file"]  = file
            }
            //parmeters["file"] = file == nil ? "" : file
            
            return .uploadCompositeMultipart([MultipartFormData(provider: .data(file ?? Data()), name: "file")], urlParameters: parmeters)

        //我的任务
            
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
        
        //个人中心
        
        case .login(let userName,let password):
            let user = UserAccount.shardAccount
            parmeters["userName"] = userName
            parmeters["password"] = password
            parmeters["schoolId"] = user.schoolId
            parmeters["userType"] = user.userType
            parmeters["lat"] = user.lat
            parmeters["lng"] = user.lng
            
        case .userInfo(let user):
            parmeters["userId"] = user.userId
            parmeters["userType"] = user.userType
        case .userInfoById(let id,let userType):
            parmeters["userId"] = id
            parmeters["userType"] = userType
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        var headers : [String:String] = [:]
        headers["Authorization"] = UserAccount.shardAccount.token
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
    
    func MyRequest(_ target: Target, completion:@escaping (_ result: Result<Moya.Response, MoyaError>) -> Void) -> Cancellable{
        
        let com = {(_ result: Result<Moya.Response, MoyaError>)->() in
            switch result {
            case .success(let resp):
                guard let json = JSON(resp.data).dictionaryObject else {return}
                let errorMsg = json["errorMsg"]
                
                if(errorMsg != nil){
                    print(errorMsg as Any)
                    //FIXME: 需要重新登陆
                    
                }
                completion(result)
            case .failure(let error):
                print(error)
                completion(result)
            }
        }
        
        return request(target, completion: com)
    }
    
    @discardableResult
    open func requestModel<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion:@escaping((_ returnData: T?) -> Void)) -> Cancellable? {
        
        return MyRequest(target, completion: { (result) in
            //guard let completion = completion else { return }
            switch result {
            case .success(let response):
                guard
                    let returnData = try? response.mapModel(T.self) else {completion(nil);return}
                
                completion(returnData)
                
            case .failure(_):
                completion(nil)
            }
            
        })
    }
    @discardableResult
    open func requestData<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion:@escaping((_ returnData: T?) -> Void)) -> Cancellable? {
        
        return MyRequest(target, completion: { (result) in
            //guard let completion = completion else { return }
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
                                    completion: @escaping((_ returnDataList: [T]?) -> Void)) -> Cancellable? {
        
        return MyRequest(target, completion: { (result) in
            //guard let completion = completion else { return }
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
