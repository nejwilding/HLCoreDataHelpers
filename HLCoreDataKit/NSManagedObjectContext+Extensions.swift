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
     Create a private queued managed object context
     
     - Returns: NSManagedObjectContext
     */
    public func createBackgroundContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }
    
    /**
     Insert Managed Object conforming to ManagedObjectType into context
     
     - Returns: ManagedObject
     */
    public func insertObject<A: ManagedObject>() -> A where A: ManagedObjectType {
    	let object = A(context: self)
        return object
    }
    
    /**
     Save or rollback
     
     - Returns: Bool of save success
     */
    public func saveOrRollback() -> CoreDataSaveResult {
        do {
            try save()
            return .success
        } catch(let error) {
            rollback()
            return .failure(error as NSError)
        }
    }
    
    /**
     Perform block function and save
     */
    public func performChanges(_ block: @escaping () -> ()) {
        perform {
            block()
            _ = self.saveOrRollback()

        }
    }
    
    /**
     Save current context
     */
    public func saveInContext(_ completion: ((CoreDataSaveResult) -> Void)? = nil) {
        perform {
            if self.hasChanges {
                let result = self.saveOrRollback()
                completion?(result)
            }
        }
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
