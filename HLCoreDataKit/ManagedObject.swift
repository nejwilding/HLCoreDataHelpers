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
    //associatedtype FetchRequestResult: NSFetchRequestResult
    static var defaultSortDescriptors: [SortDescriptor] { get }
    static var defaultPredicate: Predicate { get }
}

extension ManagedObjectType {
    
    public static var defaultSortDescriptors: [SortDescriptor] {
        return []
    }
    
    public static var defaultPredicate: Predicate {
        return Predicate(value: true)
    }
}

extension ManagedObjectType {

    public static func sortedFetchRequest<T: NSManagedObject>() -> NSFetchRequest<T> {
        let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(T.self))
        request.predicate = defaultPredicate
        print(defaultPredicate)
        request.sortDescriptors = defaultSortDescriptors
        return request
        
    }
    
    public static func sortedFetchRequestWithPredicate<T: NSManagedObject>(_ predicate: Predicate) -> NSFetchRequest<T> {
        let request: NSFetchRequest<T> = sortedFetchRequest()
        guard let existingPredicate = request.predicate else {
            fatalError("Must have default predicate")
        }
        
        request.predicate = CompoundPredicate(andPredicateWithSubpredicates: [existingPredicate, predicate])
        return request
    }
    
    public static func sortedFetchRequestWithMultiplePredicates<T: NSManagedObject>(_ predicates: [Predicate]) -> NSFetchRequest<T> {
        let request: NSFetchRequest<T> = sortedFetchRequest()
        guard let existingPredicate = request.predicate else {
            fatalError("Must have default predicate")
        }
        
        var predicateList = [existingPredicate]
        predicateList.append(contentsOf: predicates)
        
        request.predicate = CompoundPredicate(andPredicateWithSubpredicates: predicateList)
        return request
    }
}

