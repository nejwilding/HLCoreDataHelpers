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
    //associatedtype FetchRequestResult: NSFetchRequestResult
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
    static var defaultPredicate: NSPredicate { get }
}

extension ManagedObjectType {
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    public static var defaultPredicate: NSPredicate {
        return NSPredicate(value: true)
    }
}

extension ManagedObjectType {

    public static func sortedFetchRequest<T: NSManagedObject>() -> NSFetchRequest<T> {
        let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        request.predicate = defaultPredicate
        request.sortDescriptors = defaultSortDescriptors

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
    
    public static func findOrCreate(inContext moc: NSManagedObjectContext, matchingPredicate predicate: NSPredicate, configure: (Self) -> ()) -> Self {
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
            typealias T = Self
            let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
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
    
    public static func fetch(inContext moc: NSManagedObjectContext, configurationBlock: (NSFetchRequest<Self>) -> ()) -> [Self] {
        
        typealias T = Self
        let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        configurationBlock(request)
        guard let result = try? moc.fetch(request) else {
            fatalError("Fetched objects wrong type") }
        return result
   }
    
    public static func count(inContext moc: NSManagedObjectContext, configurationBlock: (NSFetchRequest<Self>) -> ()) -> Int {
        typealias T = Self
        let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        configurationBlock(request)

        do {
            let result = try moc.count(for: request)
            return result
        } catch {
            fatalError("Failed to execute fetch \(error)")
        }
    }
    
    //TOFIX: swift 3 xcode issue
    public static func lastModified(inContext moc: NSManagedObjectContext, configurationBlock: (NSFetchRequest<Self>) -> ()) -> Self? {
        typealias T = Self
        let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        request.fetchLimit = 1
        request.returnsObjectsAsFaults = false
        configurationBlock(request)
        guard let result = try? moc.fetch(request) else {
            fatalError("Fetched objects wrong type") }
        return result.first
    }

}

