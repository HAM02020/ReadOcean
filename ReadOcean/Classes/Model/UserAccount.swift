//
//  UserAccount.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/18.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation
import SwiftyJSON
import HandyJSON
private let accountFile = "userAccount.json"

let shardAccount = UserAccount.build()

var userLogon:Bool{
    get{
        return shardAccount.token != nil
    }

}
class UserAccount:HandyJSON{
    
    var userId:String = "F2F9105E-B6F8-C2A2-279A-A9DF84701F57"
    
    var userType:String = "user_type_student"
    
    var token:String?
    
    var schoolId:Int = 1000000
    
    var lat:Int = 1
    
    var lng:Int = 1
    
    var userInfo:UserInfo?{
        didSet{
            
            saveAccount()
        }
    }
    
    var searchHistoryArray = [String]()

    
    required init() {
        
    }
    static func build()->UserAccount{
        //从磁盘加载保存的文件
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (docDir as NSString).appendingPathComponent(accountFile)
        guard
            let data = NSData(contentsOfFile: filePath),
            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:Any],
            let userAccount = UserAccount.deserialize(from: dict)
        else {
            return UserAccount()
        }
        print("从沙盒取到的用户信息！！！！！！！\(filePath)")
        return userAccount
        
    }
    
    func saveAccount() {
        var dict = [String:Any]()
        dict["userId"] = userId
        dict["userType"] = userType
        dict["token"] = token
        dict["schoolId"] = schoolId
        dict["lat"] = lat
        dict["lng"] = lng
        dict["token"] = token
        dict["userInfo"] = userInfo?.toJSON()
        dict["searchHistoryArray"] = searchHistoryArray
        // 字典序列化
        
        guard let data =  try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]) else {
            return
        }
        // 写入磁盘
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (docDir as NSString).appendingPathComponent(accountFile)
        
        (data as NSData).write(toFile: filePath, atomically: true)
        print("用户账户保存成功\(filePath)")
    }
    func deleteAccount(){
        token = nil
        // 写入磁盘
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (docDir as NSString).appendingPathComponent(accountFile)
        let fileManger = FileManager.default
        do{
            try fileManger.removeItem(atPath: filePath)
            print("Success to remove file.")
        }catch{
            print("Failed to remove file.")
        }

    }
    func saveSearchHistory(){
        DispatchQueue.main.async {
            //读
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let filePath = (docDir as NSString).appendingPathComponent(accountFile)
            guard
                let rdata = NSData(contentsOfFile: filePath),
                var dict = try? JSONSerialization.jsonObject(with: rdata as Data, options: []) as? [String:Any]
            else {return}
            
            dict["searchHistoryArray"] = self.searchHistoryArray
            //写
            // 字典序列化
            guard let wdata =  try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]) else {return}
            (wdata as NSData).write(toFile: filePath, atomically: true)
            print("搜索记录保存成功\(filePath)")
        }
        
        
    }
    
//    static let main:UserAccount = {
//        let instance = UserAccount.build()
//        return instance
//    }()
    
}
