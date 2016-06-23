//
//  CoreDataExtensions.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 19/06/2015.
//  Copyright (c) 2015 Nicholas Wilding. All rights reserved.
//

import Foundation
import CoreData

public func entity(name: String, context: NSManagedObjectContext) -> NSEntityDescription {
    return NSEntityDescription.entity(forEntityName: name, in: context)!
}


public func sortDescriptor(key: String, ascending: Bool? = true) -> SortDescriptor {
    return SortDescriptor(key: key, ascending: ascending ?? true)
}

public class FetchRequest <T: NSManagedObject>: NSFetchRequest<AnyObject> {
    
    public init(entity: NSEntityDescription, fetchLimit: Int? = nil, batchSize: Int? = nil, sorts: [SortDescriptor]? = nil ) {
        super.init()
        self.entity = entity
    
        if let sorts = sorts {
            self.sortDescriptors = sorts
        }
        
        if let fetchLimit = fetchLimit {
            self.fetchLimit = fetchLimit
        }
        
        if let batchSize = batchSize {
            self.fetchBatchSize = batchSize
        }
        
    }
}





