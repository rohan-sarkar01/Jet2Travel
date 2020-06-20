//
//  ArticleViewModel.swift
//  Jet2Travel
//
//  Created by Rohan Sarkar on 19/06/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON
import Alamofire

class ArticleViewModel
{
    
    func loadSectionsList(_ parameters: [String : Any], urlString: String, _ completeHandler: @escaping(String, String, String) -> ()) -> Void
    {
        let connection = ServerConnection.init()
        connection.startByGet(urlString , parameters: parameters) { (networkStatus, response, error) in
            if networkStatus == "false"
            {
                completeHandler("false", "", "")
            }
            else
            {
                if error != nil
                {
                    let httpError: NSError = error!
                    completeHandler("true", "-1", httpError.localizedDescription)
                    return
                }
                else
                {
                    if response.count > 0
                    {
                        self.populateData(data: response)
                        completeHandler("true", "1", "")
                        return
                    }
                    else
                    {
                        let error: String = "Oops! Something went wrong."
                        completeHandler("true", "0", error)
                        return
                    }
                }
            }
        }
    }
    
    
    func populateData(data: JSON)
    {
        guard let array = data.array else {
            return
        }
        
        _ = array.map(createArticleEntityFrom(json:))
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        do{
            try context.save()
        }catch let error {
            print("Coredata Error : \(error)")
        }
    }
    
    func createArticleEntityFrom(json: JSON) -> Article?
    {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        if let articleEntity = NSEntityDescription.insertNewObject(forEntityName: "Article", into: context) as? Article
        {
            articleEntity.articleComments = json["comments"].stringValue
            articleEntity.articleLikes = json["likes"].stringValue
            articleEntity.articleContent =  json["content"].string
            articleEntity.articleCreatedOn = json["createdAt"].string
            articleEntity.articleImageUrl = json["media"][0]["image"].string
            articleEntity.articleTitle = json["media"][0]["title"].string
            articleEntity.articleUrl = json["media"][0]["url"].string
            
            if let users = json["user"].array
            {
                for user in users
                {
                    if let userEntity = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User
                    {
                        userEntity.userName = user["name"].string
                        userEntity.userDesignation = user["designation"].string
                        userEntity.userImageUrl = user["avatar"].string
                        articleEntity.addToUsers(userEntity)
                    }
                }
            }
            return articleEntity
        }
        return nil
    }
}
