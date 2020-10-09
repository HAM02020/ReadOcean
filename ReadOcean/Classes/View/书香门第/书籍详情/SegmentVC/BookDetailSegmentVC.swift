//
//  BookDetailSegmentVC.swift
//  阅读海洋
//
//  Created by ruruzi on 2020/9/30.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit



class BookDetailSegmentVC:BaseViewController,WMZPageProtocol{
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    class func initFromStoryBoard()->BookDetailSegmentVC{
        let storyboard = UIStoryboard(name: "BookDetailStoryBoard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookDetailSegmentVC") as! BookDetailSegmentVC
        
        return vc
    }
    func getMyScrollView()->UIScrollView{
        return self.scrollView
    }
    
}
