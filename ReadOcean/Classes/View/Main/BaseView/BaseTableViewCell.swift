//
//  BaseTableViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/8/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import Reusable
class BaseTableViewCell: UITableViewCell, Reusable {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupLayout()
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style,reuseIdentifier:reuseIdentifier)
        setupLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open func setupLayout() {}

}
extension BaseTableViewCell{
    func addDashdeBorderLayer(by view:UIView){
        let imgV:UIImageView = UIImageView(frame: CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 5))
        view.addSubview(imgV)
        UIGraphicsBeginImageContext(imgV.frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(CGLineCap.square)
        
        let lengths:[CGFloat] = [5]
        
        context?.setStrokeColor(UIColor(hexString: "8a8a8a").cgColor)
        context?.setLineWidth(1)
        context?.setLineDash(phase: 0, lengths: lengths)
        context?.move(to: CGPoint(x: 0, y: 3))
        context?.addLine(to: CGPoint(x: view.bounds.width, y: 3))
        context?.strokePath()

        imgV.image = UIGraphicsGetImageFromCurrentImageContext()
     //结束
        UIGraphicsEndImageContext()
    }
   
}
