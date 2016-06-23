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

    @NSManaged public var firstname: String?
    @NSManaged public var surname: String?
    @NSManaged public var age: NSNumber?
    @NSManaged public var gender: String?

}
