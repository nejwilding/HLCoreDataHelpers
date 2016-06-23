//
//  ManagedObject.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 29/04/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import CoreData

public class ManagedObject: NSManagedObject { }

public protocol ManagedObjectType: class {
    static var entityName: String { get }
    static var defaultSortDesciptors: [SortDescriptor] { get }
}

extension ManagedObjectType {
    
    public static var defaultSortDescriptors: [SortDescriptor] {
        return []
    }
    
    public static var sortedFetchRequest: NSFetchRequest<AnyObject> {
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = defaultSortDesciptors
        return request
    }
}
