//
//  Person+CoreDataProperties.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var firstname: String?
    @NSManaged var surname: String?
    @NSManaged var age: NSNumber?
    @NSManaged var gender: String?

}
