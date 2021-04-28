//
//  YDBlockDetailSegmentTableViewCell.swift
//  ReadOcean
//
//  Created by ruruzi on 2021/4/16.
//  Copyright © 2021 HAM02020. All rights reserved.
//

import UIKit
import Reusable
import WebKit
import SwiftyJSON
class YDBlockDetailPostTableViewCell:UITableViewCell{
    
    var categoryName:String? {
        didSet{
            typeButton.setTitle(categoryName, for: UIControl.State())
        }
    }
    
    var viewModel: Post?{
        didSet{
            guard let viewModel = viewModel,
                  let authorName = viewModel.publisher,
                  let publishDate = viewModel.publishDate,
                  let publisherId = viewModel.publisherId,
                  let likeNum = viewModel.likeNum,
                  let title = viewModel.title,
                  let postText = viewModel.description,
                  let media = viewModel.media
            else {
                return
            }
            nameLabel.text = authorName
            let dateformat = DateFormatter()
            dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            timeLabel.text =  dateformat.string(from: Date(timeIntervalSince1970: publishDate/1000))
            likeNumLabel.text = "\(likeNum)"
            titleLabel.text = title
            postTextLabel.text = postText
            postImageView?.mg_setImage(urlString: media, placeholderImage: nil, isAvatar: false)
            if(media.hasPrefix("http")){
                soundVIew?.load(URLRequest(url: URL(string: media)!))
            }
            
            if let postImageViewHeightLC = postImageViewHeightLC{
                postImageViewHeightLC.constant = viewModel.picHeight ?? postImageViewHeightLC.constant
            }
            Api.networkManager.MyRequest(.userInfoById(userId: publisherId)) { (result) in
                switch result{
                case .success(let response):
                    let json = JSON(response.data)
                    let avatorImgStr = json["avatar"].stringValue
                    self.avatarImageView.mg_setImage(urlString: avatorImgStr, placeholderImage: nil, isAvatar: true)
                case .failure(_):
                    break
                }
            }
            
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        //异步绘制 离屏渲染
        self.layer.drawsAsynchronously = true
        
        //栅格化
        //必须指定分辨率 不然h很模糊
        self.layer.shouldRasterize = true
        //分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        //优化
        self.layer.isOpaque = true
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //异步绘制 离屏渲染
        self.layer.drawsAsynchronously = true
        
        //栅格化
        //必须指定分辨率 不然h很模糊
        self.layer.shouldRasterize = true
        //分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        //优化
        self.layer.isOpaque = true
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var likeIcon: UIButton!
    @IBOutlet weak var likeNumLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView?
    @IBOutlet weak var postImageViewHeightLC: NSLayoutConstraint?
    
    @IBOutlet weak var soundVIew: WKWebView?{
        didSet{
            soundVIew?.navigationDelegate = self
            soundVIew?.allowsBackForwardNavigationGestures = true
        }
    }
    
    
}
extension YDBlockDetailPostTableViewCell: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        webView.evaluateJavaScript("var b = document.body;var c = b.children[0];c.autoplay = false;alert(c);", completionHandler: nil)
    }
}
