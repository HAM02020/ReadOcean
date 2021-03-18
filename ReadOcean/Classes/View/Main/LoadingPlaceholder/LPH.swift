//
//  LoadingPlaceholder.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/18.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class LPH {
    
    static func getPlaceHolderView()->LoadingPlaceholderView{
        let loadingCover = LoadingPlaceholderView()
        loadingCover.gradientColor = .white
        loadingCover.backgroundColor = .white
        loadingCover.fadeAnimationDuration = TimeInterval(0.5)
        //LoadingPlaceholderView.GradientiConfiguration() .animationDuration = TimeInterval(0.5)
        return loadingCover
    }
    private static let main:LoadingPlaceholderView = {
        
        return getPlaceHolderView()
    }()
    static func cover(_ viewToCover: UIView, animated: Bool = false){
        //main.uncover()
        main.cover(viewToCover,animated: animated)
        
        
    }
    static func uncover(){
        main.uncover()
    }
    
    func getxxx(title: String)->UINavigationController{
        var n = UINavigationController();
        n.title = title
        return n
    }
    
}
