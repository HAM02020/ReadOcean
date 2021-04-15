//
//  YDSearchResultTableViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/14.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit
import Reusable
class YDSearchResultTableViewCell: UITableViewCell,NibReusable{

    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc1: UILabel!
    
    @IBOutlet weak var desc2: UILabel!
    
    var bookId: String?{
        didSet{
            guard let bookId = bookId else {return}
            print("bookId = \(bookId)")
            networkManager.requestModel(.bookDetail(bookId: bookId), model: Book.self) { (model) in
                guard let model = model,
                      let titleStr = model.title,
                      let `description` = model.introduction,
                      let img = model.coverImg else {return}
                      //let remark = model.remark else {return}
                self.coverImageView.mg_setImage(urlString: img, placeholderImage: UIImage(named: "placeholder"))
                self.title.text = titleStr
                self.desc1.text = `description`
                self.desc2.text = ""
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
