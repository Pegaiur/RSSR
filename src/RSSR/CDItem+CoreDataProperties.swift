//
//  CDItem+CoreDataProperties.swift
//  
//
//  Created by Pegaiur on 15/10/26.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CDItem {

    @NSManaged var sourceId: String?
    @NSManaged var link: String?
    @NSManaged var title: String?
    @NSManaged var author: String?
    @NSManaged var date: String?
    @NSManaged var updateDate: NSDate?
    @NSManaged var summary: String?
    @NSManaged var content: String?
    @NSManaged var enclosures: String?
    @NSManaged var identifier: String?
    @NSManaged var isRead: NSNumber?

}
