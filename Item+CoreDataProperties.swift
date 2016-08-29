//
//  Item+CoreDataProperties.swift
//  Dream Lister
//
//  Created by Steven Yang on 8/26/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import Foundation
import CoreData

extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var price: Double
    @NSManaged public var created: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var toStore: Store?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toImage: Image?

}
