//
//  NSArray+Extensions.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/1.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation
 
extension NSObject {
    
    // MARK:
    // MARK: 只包含一种元素类型的array 是否相同
    /// 只包含一种元素类型的array 是否相同
     func arrayIsEqualToASortOfArray(firstArray: NSArray,thenArray: NSArray) -> Bool {
 
        // 当所有元素都是 字符串 类型
        if (firstArray[0] as AnyObject).isKind(of: NSString.self) {
            
            // 类型转换
            let firstA = firstArray as! [String];
            
            let thenA = thenArray as! [String];
 
            for i in firstA {
                
                // 如果出现不相等 直接返回
                if thenA.contains(i) == false {
                
                    return false;
                }
            }
            
            // 执行到这里说明全部相等
            return true;
        }
        
        // 当所有元素都是 数字 类型
        if (firstArray[0] as AnyObject).isKind(of:NSNumber.self) {
            
            // 类型转换
            let firstA = firstArray as! [NSNumber];
            
            let thenA = thenArray as! [NSNumber];
            
            for i in firstA {
                
                // 如果出现不相等 直接返回
                if thenA.contains(i) == false {
                    
                    return false;
                }
            }
            
            // 执行到这里说明全部相等
            return true;
        }
 
        return false;
    }
 
    // MARK:
    // MARK: 一个数组是否包换另一个数组所有元素
    /// 一个数组是否包换另一个数组所有元素
    func arrayIsContain(firstArray: NSArray,isContainedByArray: NSArray) -> Bool {
 
        if firstArray.count > isContainedByArray.count {
            
            print("被包含数组长度小于包含数组长度");
            
            return false;
        }
        
        return publicCode(firstArray: firstArray, thenArray: isContainedByArray);
 
    }
 
    // MARK:
    // MARK: 二个数组中的所有元素是否相等
    /// 用于数组中元素不止一种 判断二个数组中的所有元素是否相等
    func arrayIsEqual(firstArray: NSArray,thenArray: NSArray) -> Bool {
        
        if firstArray.count != thenArray.count {
            
            return false;
        }
        
        return publicCode(firstArray: firstArray, thenArray: thenArray);
    }
   
}
 
// MARK:
// MARK: 抽取
extension NSObject {
    
    
    // MARK:
    // MARK: 公用代码
    /// 公用代码
    private func publicCode(firstArray: NSArray,thenArray: NSArray) -> Bool {
        
        let count = firstArray.count;
        
        // 相同的标记
        var rightCount = 0;
        
        for i in 0..<count {
            
            // 获取元素
            let obj = firstArray[i];
            
            // 判断 NSString类型
            if (obj as AnyObject).isKind(of: NSString.self) {
                
                for j in thenArray {
                    
                    // 获得所有 相同类型
                    if (j as AnyObject).isKind(of: NSString.self) {
                        
                        let thenObj = j as! String;
                        
                        if obj as! String == thenObj {
                            
                            rightCount += 1;
                        }
                        
                    }
                }
                
            }
            
            // 判断 NSNumber类型
            if (obj as AnyObject).isKind(of: NSNumber.self) {
                
                for j in thenArray {
                    
                    // 获得所有 相同类型
                    if (j as AnyObject).isKind(of: NSNumber.self) {
                        
                        let thenObj = j as! NSNumber;
                        
                        if obj as! NSNumber == thenObj {
                            
                            rightCount += 1;
                        }
                        
                    }
                }
                
            }
            
            
        }
        
        return count == rightCount;
    }
    
}
