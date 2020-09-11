//
//  ProfileSettingModel.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/10.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation

struct PModel{
    var iconName:String?
    var title:String?
    init(_ iconName:String,_ title:String) {
        self.iconName = iconName
        self.title = title
    }
}
