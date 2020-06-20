//
//  ArticleCell.swift
//  Jet2Travel
//
//  Created by Rohan Sarkar on 20/06/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class ArticleCell: UITableViewCell
{
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var imgArticle: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserDesignation: UILabel!
    @IBOutlet weak var articleContent: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleUrl: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.outerView.clipsToBounds = true
        self.outerView.layer.cornerRadius = 10
        self.outerView.backgroundColor = UIColor(red: 06.0/255.0, green: 59.0/255.0, blue: 105.0/255.0, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(info: Article)
    {
        self.articleContent.text = info.articleContent
        self.articleTitle.text = info.articleTitle
        self.articleUrl.text = info.articleUrl
        self.lblLike.text = Util.sharedInstance.convertToFloatValue(val: info.articleLikes ?? "0") + " Likes"
        self.lblComment.text = Util.sharedInstance.convertToFloatValue(val: info.articleComments ?? "0") + " Comments"
        if info.articleImageUrl != nil
        {
            self.imgArticle.kf.indicatorType = .activity
            let picUrl = URL(string: info.articleImageUrl!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            self.imgArticle.kf.setImage(with: picUrl!, placeholder: UIImage(named: "Placeholder"))
        }
        else
        {
            self.imgArticle.image = UIImage(named: "Placeholder")
        }
        let userInfo = info.users?.allObjects as! [User]
        for i in 0..<userInfo.count
        {
            self.lblUserName.text = userInfo[i].userName
            self.lblUserDesignation.text = userInfo[i].userDesignation
            if userInfo[i].userImageUrl != nil
            {
                self.imgUser.kf.indicatorType = .activity
                let picUrl = URL(string: userInfo[i].userImageUrl!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                self.imgUser.kf.setImage(with: picUrl!, placeholder: UIImage(named: "Placeholder_100"))
            }
        }
    }

}
