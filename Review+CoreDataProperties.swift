//
//  Review+CoreDataProperties.swift
//  imdb
//
//  Created by user215932 on 5/8/22.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var movie: String?
    @NSManaged public var reviewContents: String?
    @NSManaged public var name: String?
    @NSManaged public var rating: String?

}

extension Review : Identifiable {

}
