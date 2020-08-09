//
//  CommunityView.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/9.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class CommunityView: UIView {

    @IBOutlet weak var bg: UIView!
    
    class func communityView() -> CommunityView{
        let nib = UINib(nibName: "CommunityView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! CommunityView
        return v
    }
    

}
