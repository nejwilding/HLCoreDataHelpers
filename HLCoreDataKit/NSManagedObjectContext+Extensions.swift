//
//  NSManagedObjectContext+Extensions.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 29/04/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    /**
     Insert Managed Object conforming to ManagedObjectType into context
     
     - Returns: ManagedObject
     */
    public func insertObject<A: ManagedObject where A: ManagedObjectType>() -> A {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("Object type invalid")
        }
        
        return object
    }
    
    
    public func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    
    public func performChanges(_ block: () -> ()) {
        perform {
            block()
            self.saveOrRollback()
        }
    }
    
    // Alias for Save result
    public typealias ContextSaveResult = (success: Bool, error: NSError?)
    
    //MARK: - Save
    
    /// Save context of managed Object
    ///
    /// - Parameter completion:       Closure return of ContextSaveResult
    public func saveContext(_ completion: ((ContextSaveResult) -> Void)? = nil) {
        
        self.performAndWait({ () -> Void in
            do {
                if self.hasChanges {
                    try self.save()
                    
                    guard self.parent?.hasChanges == true else {
                        return
                    }
                    
                    self.parent?.perform({ () -> Void in
                        
                        do {
                            try self.parent?.save()
                        }
                        catch {
                            assertionFailure("*** Error saving writer context \(error)")
                        }
                        
                    })
                    
                    completion?((true, nil))
                }
            } catch let error as NSError? {
                completion?((false, error))
            }
        })
    }
    
    
    // MARK: - Fetch Results
    
    /// fetch results count
    ///
    /// :param: request     Fetch Request containing search criteria
    /// :para: inContext    Managed Object Context to perform fetch within
    ///
    /// :return: returns count of fetch as integer
    public func fetchCount(_ request: NSFetchRequest<AnyObject>) throws -> Int {
        
        var error: NSError?
        let count = self.count(for: request, error: &error)
        
        guard error == nil else {
            throw error!
        }
        
        return count
        
    }
    
    
    /// Fetch results objects
    ///
    /// :param: request     Fetch Request containing search criteria
    /// :param: inContext   Managed Object Context to perform fetch within
    ///
    /// :return: returns Fetch Result of generic Type
    public func fetch <T: NSManagedObject> (_ request: FetchRequest<T>) throws ->  [T] {
        
        var results = [AnyObject]()
        var caughtError: NSError?
        
        self.performAndWait {
            do {
                results = try self.fetch(request)
            } catch {
                caughtError = error as NSError
            }
        }
        
        guard caughtError == nil else {
            throw caughtError!
        }
        
        return results as! [T]
    }
    
    
    // MARK: - Delete
    
    /// Deletes objects within a given managed object context
    ///
    /// :param: objects     The objets that are to be delted
    /// :param: inContext   The managed object context to delete them from
    public func deleteObjects <T: NSManagedObject>(_ objects:[T]) {
        
        guard objects.count > 0 else {
            return
        }
        
        self.performAndWait { () -> Void in
            for each in objects {
                self.delete(each)
            }
        }
        
    }
    
}
