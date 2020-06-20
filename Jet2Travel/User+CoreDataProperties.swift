//
//  User+CoreDataProperties.swift
//  Jet2Travel
//
//  Created by Rohan Sarkar on 19/06/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userName: String?
    @NSManaged public var userDesignation: String?
    @NSManaged public var userImageUrl: String?
    @NSManaged public var articles: Article?

}
