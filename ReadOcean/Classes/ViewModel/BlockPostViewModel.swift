//
//  BlockPostViewModel.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/21.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit
import SwiftyJSON
class BlockPostViewModel{
    
    static func publishPost(category: String, blockId: String, userId:String = UserAccount.shardAccount.userId, title: String, description:String, isImg: Bool, file:Data?, completion:@escaping(_ isSuccess: Bool)->()){
        let voiceId = isImg ? nil : UUID().uuidString
        Api.networkManager.request(.publishPost(category: category, blockId: blockId, title: title, description: description, voiceId: voiceId, file: file)) { (result) in
            
            switch result{
            case .success(let response):
                print(try? response.mapString())
                let json = JSON(response.data)
                guard let msg = json["msg"].string else{completion(false); return}
                print(msg)
                completion(true);
            case .failure(_):
                completion(false);
                break
            }
        }
       
    }
    
}
