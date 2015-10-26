//
//  CDSource+CoreDataProperties.swift
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

extension CDSource {

    @NSManaged var title: String?
    @NSManaged var link: String?
    @NSManaged var lastUpdateTime: NSDate?
    @NSManaged var summary: String?
    @NSManaged var count: NSNumber?
    @NSManaged var isRead: NSNumber?

}
