//
//  StoryBoardLoadable.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/10/22.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

protocol StoryBoardLoadable: class {
    
}
extension StoryBoardLoadable{
   
}

extension StoryBoardLoadable where Self:UIViewController{
    static func loadFromStoryBoard(storyBoardName:String,identifier:String)->Self{
        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: identifier) as Self

        return vc
    }
}
