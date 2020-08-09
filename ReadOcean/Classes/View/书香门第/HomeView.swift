//
//  HomeView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/9.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class HomeView: UIView {

    class func communityView() -> CommunityView{
        let nib = UINib(nibName: "HomeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! HomeView
        return v
    }

}
