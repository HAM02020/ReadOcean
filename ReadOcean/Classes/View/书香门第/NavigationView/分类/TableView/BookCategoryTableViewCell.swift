//
//  BookCategoryTableViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/10/25.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class BookCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var desc2: UILabel!
    
    var viewModel: Book?{
        didSet{
            guard let viewModel = viewModel,
                  let img = viewModel.picUrl,
                  let name = viewModel.name,
                  let `description` = viewModel.introduction,
                  let categoryName = viewModel.category,
                  let remark = viewModel.remark
                  else {return}
            
            cover.mg_setImage(urlString: img, placeholderImage: UIImage(named: "placeholder"))
            title.text = name
            desc.text = `description`
            desc2.text = "\(categoryName) · \(remark)"
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
