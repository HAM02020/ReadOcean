//
//  DiscoverBookTableViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/9/21.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
let DiscoverBookCollectionViewCellType = "DiscoverBookCollectionViewCellType"
class DiscoverBookTableViewCell: UITableViewCell {
    
    var listViewModel:[Book] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var view: UIView!{
        didSet{
//            view.layer.cornerRadius = 10
//
//
//            //view.layer.shadowRadius = 10
//            view.layer.shadowOffset = CGSize(width: 0, height: 1)
//            view.layer.shadowOpacity = 0.2
//            view.layer.shadowColor = UIColor.black.cgColor
//            view.layer.masksToBounds = false
            let subLayer = CALayer()
            //let fixframe = view.frame
            //let newFrame = CGRect(x: fixframe.minX-(375-UIScreen.main.bounds.size.width)/2, y: fixframe.minY, width: fixframe.width, height: fixframe.height) // 修正偏差
            subLayer.frame = view.frame
            subLayer.cornerRadius = 50
            subLayer.backgroundColor = UIColor.white.cgColor
            subLayer.masksToBounds = true
            subLayer.shadowColor = UIColor.black.cgColor // 阴影颜色
            subLayer.shadowOffset = CGSize(width: 0, height: 0) // 阴影偏移,width:向右偏移3，height:向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
            subLayer.shadowOpacity = 0.2 //阴影透明度
            subLayer.shadowRadius = 5;//阴影半径，默认3

            view.superview?.layer.insertSublayer(subLayer, below: view.layer)
        }
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var more: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "DiscoverBookCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DiscoverBookCollectionViewCellType)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension DiscoverBookTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listViewModel.count > 6 ? 6 : listViewModel.count
    }
    //边距？
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverBookCollectionViewCellType, for: indexPath) as! DiscoverBookCollectionViewCell
        
        cell.viewModel = listViewModel[indexPath.item]
        return cell
    }
    
    
}
