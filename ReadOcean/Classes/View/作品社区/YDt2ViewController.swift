//
//  YDt2ViewController.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/23.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class YDt2ViewController: BaseViewController {

    lazy var communityView = CommunityView.communityView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(communityView)
    }
    override func awakeFromNib() {
        
    }
    override func viewDidLayoutSubviews() {
        communityView.bg.backgroundColor = UIColor.red
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar
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
