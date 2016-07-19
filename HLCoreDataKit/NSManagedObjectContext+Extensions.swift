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
     Save or rollback
     
     - Returns: Bool of save success
     */
    public func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    
    /**
     Perform block function and save
     */
    public func performChanges(block: () -> ()) {
        perform {
            block()
            self.saveOrRollback()
        }
    }
    
    /**
     Save current context
     */
    public func saveInContext() {
        perform {
            if self.hasChanges {
                self.saveOrRollback()
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
