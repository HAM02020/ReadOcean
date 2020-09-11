//
//  YDBooksListViewModel.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/6/12.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import SDWebImage
import HandyJSON

class YDBooksListViewModel{
    
    lazy var booksList = [YDBookViewModel]()
    

    
    
    func loadBooks(completion:@escaping(_ isSuccess:Bool)->()){
        loadBookIds { (iDlist, isSuccess) in
            
            let url = hostAddress + "/mobileBook/infoBook"
            var array = [YDBookViewModel]()
            
            let group = DispatchGroup()
            
            for id in iDlist{
                group.enter()
                
                let params = ["bookId":id] as [String : AnyObject]
                YDNetworkManager.shared.request(URLString: url, parameters: params) { (json, isSuccess) in

                    guard
                        let json = json as? [String:Any],
                        let result = ReturnData<Book>.deserialize(from: json),
                        let model = result.data
                        else{
                        return
                    }
                    
                    array.append(YDBookViewModel(model: model))
                    group.leave()
                }

            }
            group.notify(queue: DispatchQueue.main) {
                print(array)
                self.booksList += array
                completion(true)
            }
        
            
        }
        
    }

    func loadBookIds(page:Int = 1,completion:@escaping(_ idList:[String],_ isSuccess:Bool)->()){
        let url = hostAddress + "/mobileBook/index"
        let params = ["userId":"F2F9105E-B6F8-C2A2-279A-A9DF84701F57",
                      "page":page ,
            ] as [String : AnyObject]
        
        YDNetworkManager.shared.request(URLString: url, parameters: params) { (json, isSuccess) in
            
            
            
            guard
                let data = json?["data"] as? [String:AnyObject],
                let dataList = data["dataList"] as? [[String:AnyObject]]
                
                else{
                    completion([],false)
                    return
            }
            var array:[String] = Array()
            for idDict in dataList{
                guard let id = idDict["id"] as? String else{
                    completion([],false)
                    return
                }
                array.append(id)
            }
            print(array)
            completion(array,true)
            
            
        }
    }
    
    ///缓存本次下载微博数据数组中的单张图像
    private func casheSingleImage(list:[YDBookViewModel],finished:@escaping(_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
       
        //调度组
        let group = DispatchGroup()
        
        //  记录数据长度
        var length = 0
         //遍历数组 查找微博数据中有单张图像的 进行缓存
        for vm in list {
            

            //2> 获取图像模型
            guard let pic_str = vm.book.picUrl,
                let url = URL(string: pic_str) else {
                    continue
            }
            print("要缓存的URL是\(pic_str)")
            
            
            //入组
            group.enter()
            
            //3 > 下载图像
            SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (image, _, _, _, _, _) in
                
                //将图像转成二进制数据
                if let image = image ,
                    let data = image.pngData(){
                    
                    length += data.count
                    //更新配图视图的大小
                    //vm.updateSingleImageSize(image: image)
                }
                print("缓存的图像是 \(String(describing: image) )长度 \(length)")
                
                //  出组
                group.leave()
            }
            
        }
        
        // 监听调度组情况
        group.notify(queue: DispatchQueue.main) {
            print("图像缓存完成\(length/1024)K")
            //执行闭包回调
            finished(true,true)
        }
    }
    
    
}
