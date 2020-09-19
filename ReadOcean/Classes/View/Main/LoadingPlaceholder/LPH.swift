//
//  LoadingPlaceholder.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/18.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class LPH {
    
    private static let main:LoadingPlaceholderView = {
        let loadingCover = LoadingPlaceholderView()
        loadingCover.gradientColor = .white
        loadingCover.backgroundColor = .white
        loadingCover.fadeAnimationDuration = TimeInterval(0.5)
        //LoadingPlaceholderView.GradientiConfiguration() .animationDuration = TimeInterval(0.5)
        return loadingCover
    }()
    static func cover(_ viewToCover: UIView, animated: Bool = false){
        main.cover(viewToCover,animated: animated)
    }
    static func uncover(){
        main.uncover()
    }
}
