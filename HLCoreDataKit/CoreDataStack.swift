//
//  CoreDataStack.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 29/05/2015.
//  Copyright (c) 2015 Nicholas Wilding. All rights reserved.
//

import Foundation
import CoreData

// Alias for NSManagedObject Context
public typealias ChildManagedObjectContact = NSManagedObjectContext


/// Instance of CoreDataStack for SQLStoreType
/// Manages CoreDatStack and CoreDataModel
/// Creates parent ObjectContext of writer with a child of managedObjectContext
public final class CoreDataStack {
    
    // MARK: - Properties
    
    public let mainObjectContext: NSManagedObjectContext
    fileprivate let persistentStoreCoordinator: NSPersistentStoreCoordinator
    fileprivate let model: CoreDataModel

    
    // MARK: Initializtion
    
    /**
    Constructs a new CoreDataStack, with model, storeType, and concurentType

    - Parameter model:            Data model of the current stack
    - Parameter storeType:        StoreStype of PersistentStoreCoordinator. Default is SQLLiteStoeType
    - Parameter concurrentType:   ConcurrencyType of Store. Default is on the MainQueue
 
    -Returns: A new CoreDataStack
    */
    public init(model: CoreDataModel, concurrentType : NSManagedObjectContextConcurrencyType = .mainQueueConcurrencyType) {

        // set up model and persistentStore
        self.model = model
        self.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model.modelVersion.managedObjectModel)
        
        // create child object context to used by public
        mainObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        // Persistent Store default options
        let options = [NSMigratePersistentStoresAutomaticallyOption: true,
        NSInferMappingModelAutomaticallyOption: true]
        
        do {
            try self.persistentStoreCoordinator.addPersistentStore(ofType: model.storeType.type, configurationName: nil, at: model.storeURL, options: options)
        } catch let error as NSError {
            assertionFailure("*** Error adding persistent store \(error)")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(CoreDataStack.contextDidSaveNotification(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Child Managed Object Context
    
    /**
     Creates a new Managed Object Context with a parent of ManagedObjectContext
 
    - Parameter concurencyType:   ConcurrencyType of Store. - Default is on the MainQueue
    - Parameter mergePolicy:      The mergepolicy to use - Defaults to MergeByPropertyObjectTrumpMergePolicyType

    - Returns: A new managed object context which is a child
     */
    public func childManagedObjectContext(_ concurrenyType: NSManagedObjectContextConcurrencyType = .mainQueueConcurrencyType, mergePolicyType: NSMergePolicyType = .mergeByPropertyObjectTrumpMergePolicyType) -> ChildManagedObjectContact {
        
        let childManagedObjectContext = NSManagedObjectContext(concurrencyType: concurrenyType)
        childManagedObjectContext.parent = mainObjectContext
        childManagedObjectContext.mergePolicy = NSMergePolicy(merge: mergePolicyType)
        
        return childManagedObjectContext
    }
    
    
    // MARK: - Managed Object Context Save Notification
    
    @objc func contextDidSaveNotification(notification: Notification) {
        print("xxxxxxxxxxxxxxxxxxxxx")

        guard let context = notification.object as? NSManagedObjectContext else {
            assertionFailure("*** Error \(notification)")
            return
        }

        print(context.registeredObjects.count)
        print(context.name)
        
        if context !== self.mainObjectContext {
            print("MERGING MERGING - Save Detected Outside Thread Main")

            mainObjectContext.perform {
                self.mainObjectContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }
    
}
