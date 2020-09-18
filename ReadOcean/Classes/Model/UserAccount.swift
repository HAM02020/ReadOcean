//
//  UserAccount.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/18.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation

class UserAccount {
    
    var userId:String = "F2F9105E-B6F8-C2A2-279A-A9DF84701F57"
    
    var userType:String = "user_type_student"
    
    var token:String?
    
    var schoolId:Int = 1000000
    static let main:UserAccount = {
        let instance = UserAccount()
        return instance
    }()
    
}
