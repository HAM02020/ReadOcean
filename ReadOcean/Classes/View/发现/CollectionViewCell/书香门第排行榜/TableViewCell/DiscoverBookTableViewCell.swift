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
    
    var delegate:DiscoverBookDelegate?
    
    @IBOutlet weak var view: UIView!{
        didSet{
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 5

            //制作阴影
            let subLayer = CALayer()
            let fixframe = view.frame
            let newFrame = CGRect(x: fixframe.minX, y: fixframe.minY, width: fixframe.height, height: fixframe.width) // 修正偏差
            subLayer.frame = newFrame
            subLayer.cornerRadius = view.layer.cornerRadius
            subLayer.backgroundColor = UIColor.white.cgColor
            subLayer.masksToBounds = false
            subLayer.shadowColor = UIColor.black.cgColor // 阴影颜色
            subLayer.shadowOffset = CGSize(width: 0, height: 0) // 阴影偏移,width:向右偏移3，height:向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
            subLayer.shadowOpacity = 0.2 //阴影透明度
            subLayer.shadowRadius = 5;//阴影半径，默认3
            //view.layer.addSublayer(subLayer)
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
    override func prepareForReuse() {
        super.prepareForReuse()
        //异步绘制 离屏渲染
        self.layer.drawsAsynchronously = true
        //栅格化
        //必须指定分辨率 不然h很模糊
        self.layer.shouldRasterize = true
        //分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        self.isOpaque = true
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

        return collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverBookCollectionViewCellType, for: indexPath) as! DiscoverBookCollectionViewCell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! DiscoverBookCollectionViewCell).viewModel = listViewModel[indexPath.item]
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let bookDetailVC = BookDetailVC()
        bookDetailVC.bookId = listViewModel[indexPath.item].id
        bookDetailVC.hidesBottomBarWhenPushed = true
        delegate?.discover(didSelectItem: bookDetailVC)
        //navigationController?.pushViewController(bookDetailVC, animated: true)
    }
}

protocol DiscoverBookDelegate {
    func discover(didSelectItem vc:UIViewController);
}
