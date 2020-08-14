//
//  YDt3ViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDt3ViewController: YDBaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = WBTittleButton(title: "按钮", image: UIImage(named: "t5"))
        btn.center = view.center
        view.addSubview(btn)
    }
    override func awakeFromNib() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
