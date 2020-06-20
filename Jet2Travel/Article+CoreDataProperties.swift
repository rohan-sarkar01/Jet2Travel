//
//  Article+CoreDataProperties.swift
//  Jet2Travel
//
//  Created by Rohan Sarkar on 19/06/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var articleContent: String?
    @NSManaged public var articleImageUrl: String?
    @NSManaged public var articleTitle: String?
    @NSManaged public var articleCreatedOn: String?
    @NSManaged public var articleLikes: String?
    @NSManaged public var articleComments: String?
    @NSManaged public var articleUrl: String?
    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for users
extension Article {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: User)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: User)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
