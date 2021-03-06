//
//  ManagedObject.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 29/04/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import CoreData

open class ManagedObject: NSManagedObject { }

public protocol ManagedObjectType: class {
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
    static var defaultPredicate: NSPredicate { get }
    static var remoteUpdatePredicate: NSPredicate { get }
    
}

extension ManagedObjectType {
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    public static var defaultPredicate: NSPredicate {
        return NSPredicate(value: true)
    }
    
    public static var remoteUpdatePredicate: NSPredicate {
        return NSPredicate(value: true)
    }
}

extension ManagedObjectType {
    
    public static func fullFetchRequest<T: NSManagedObject>() -> NSFetchRequest<T> {
        let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        return request
    }

    public static func sortedFetchRequest<T: NSManagedObject>() -> NSFetchRequest<T> {
        let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        request.predicate = defaultPredicate
        request.sortDescriptors = defaultSortDescriptors

        return request
    }
    
    public static func unsortedFetchRequest<T: NSManagedObject>() -> NSFetchRequest<T> {
        let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        request.predicate = defaultPredicate
        
        return request
    }
    
    public static func sortedFetchRequest<T: NSManagedObject>(withPredicate predicate: NSPredicate) -> NSFetchRequest<T> {
        let request: NSFetchRequest<T> = sortedFetchRequest()
        guard let existingPredicate = request.predicate else {
            fatalError("Must have default predicate")
        }
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [existingPredicate, predicate])
        return request
    }
    
    public static func sortedFetchRequest<T: NSManagedObject>(withMultiplePredicates predicates: [NSPredicate]) -> NSFetchRequest<T> {
        let request: NSFetchRequest<T> = sortedFetchRequest()
        guard let existingPredicate = request.predicate else {
            fatalError("Must have default predicate")
        }
        
        var predicateList = [existingPredicate]
        predicateList.append(contentsOf: predicates)
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateList)
        return request
    }
}

extension ManagedObjectType where Self: ManagedObject {
    
    public static func findOrCreate(inContext moc: NSManagedObjectContext,
                                    matchingPredicate predicate: NSPredicate, configure: (Self) -> Void) -> Self {
        guard let object = findOrFetch(inContext: moc, matchingPredicate: predicate) else {
            let newObject: Self = moc.insertObject()
            configure(newObject)
            return newObject
        }
        return object
    }
    
    //TOFIX: swift 3 xcode issue
    public static func findOrFetch(inContext moc: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self? {
        guard let object = materializedObjectInContext(moc, matchingPredicate: predicate) else {
            typealias Type = Self
            let request: NSFetchRequest<Type> = NSFetchRequest(entityName: String(describing: Type.self))
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            guard let result = try? moc.fetch(request) else {
                fatalError("Fetched objects wrong type") }
            return result.first
            
        }
        return object
    }
    
    public static func materializedObjectInContext(_ moc: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self? {
        for obj in moc.registeredObjects where !obj.isFault {
            guard let res = obj as? Self, predicate.evaluate(with: res) else { continue }
            return res
        }
        return nil
    }
    
    public static func fetch(inContext moc: NSManagedObjectContext,
                             configurationBlock: (NSFetchRequest<Self>) -> Void) -> [Self] {
        
        typealias Type = Self
        let request: NSFetchRequest<Type> = NSFetchRequest(entityName: String(describing: Type.self))
        configurationBlock(request)
        guard let result = try? moc.fetch(request) else {
            fatalError("Fetched objects wrong type") }
        return result
   }
    
    public static func count(inContext moc: NSManagedObjectContext,
                             configurationBlock: (NSFetchRequest<Self>) -> Void) -> Int {
        typealias Type = Self
        let request: NSFetchRequest<Type> = NSFetchRequest(entityName: String(describing: Type.self))
        configurationBlock(request)

        do {
            let result = try moc.count(for: request)
            return result
        } catch {
            fatalError("Failed to execute fetch \(error)")
        }
    }
    
    //TOFIX: swift 3 xcode issue
    public static func lastModified(inContext moc: NSManagedObjectContext,
                                    configurationBlock: (NSFetchRequest<Self>) -> Void) -> Self? {
        typealias Type = Self
        let request: NSFetchRequest<Type> = NSFetchRequest(entityName: String(describing: Type.self))
        request.fetchLimit = 1
        request.returnsObjectsAsFaults = false
        configurationBlock(request)
        guard let result = try? moc.fetch(request) else {
            fatalError("Fetched objects wrong type") }
        return result.first
    }

}

extension ManagedObjectType where Self: ManagedObject {
    
    public static func fetchSingleObject(inContext moc: NSManagedObjectContext, cacheKey: String?,
                                         configure: (NSFetchRequest<Self>) -> Void) -> Self? {
        let result = fetchSingleObject(inContext: moc, configure: configure)
        return result
        // TOFIX: Cache add
    }
    
    public static func fetchSingleObject(inContext moc: NSManagedObjectContext, configure: (NSFetchRequest<Self>) -> Void) -> Self? {
        let result = fetch(inContext: moc) { request in
            configure(request)
            request.fetchLimit = 1
        }
        switch result.count {
        case 0: return nil
        case 1: return result[0]
        default: fatalError("Returned multiple objects, expected max 1")
        }
    }
    
}
