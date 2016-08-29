//
//  Item+CoreDataClass.swift
//  Dream Lister
//
//  Created by Steven Yang on 8/26/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
