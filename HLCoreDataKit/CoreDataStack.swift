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
    
    //properties
    public let mainObjectContext: NSManagedObjectContext
    public let writerObjectContext: NSManagedObjectContext
    private let persistentStoreCoordinator: NSPersistentStoreCoordinator
    private let model: CoreDataModel

    
    // MARK: Initializtion
    
    /// Contruscts a new CoreDataStack, with model, storeType, and concurentType
    ///
    /// :param model            Data model of the current stack
    /// :param storeType        StoreStype of PersistentStoreCoordinator. Default is SQLLiteStoeType
    /// :param concurrentType   ConcurrencyType of Store. Default is on the MainQueue
    ///
    /// :returns A new CoreDataStack
    public init(model: CoreDataModel, concurrentType : NSManagedObjectContextConcurrencyType = .mainQueueConcurrencyType) {

        // set up model and persistentStore
        self.model = model
        self.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model.managedObjectModel)
        
        // create Writer Object Context as parent
        writerObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        writerObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        // create child object context to used by public
        mainObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainObjectContext.parent = self.writerObjectContext
        
        // Persistent Store default options
        let options = [NSMigratePersistentStoresAutomaticallyOption: true,
        NSInferMappingModelAutomaticallyOption: true]
        
        do {
            try self.persistentStoreCoordinator.addPersistentStore(ofType: model.storeType.type, configurationName: nil, at: model.storeURL, options: options)
        } catch let error as NSError {
            assertionFailure("*** Error adding persistent store \(error)")
        }

    }
    
    
    
    // MARK: - Child Managed Object Context
    
    /// Creates a new Managed Object Context with a parent of ManagedObjectContext
    ///
    /// :param concurencyType   ConcurrencyType of Store. 
    ///                         Default is on the MainQueue
    /// :param mergePolicy      The mergepolicy to use
    ///                         Defaults to MergeByPropertyObjectTrumpMergePolicyType
    ///
    /// :returns A new managed object context which is a child
    public func childManagedObjectContext(_ concurrenyType: NSManagedObjectContextConcurrencyType = .mainQueueConcurrencyType, mergePolicyType: NSMergePolicyType = .mergeByPropertyObjectTrumpMergePolicyType) -> ChildManagedObjectContact {
        
        let childManagedObjectContext = NSManagedObjectContext(concurrencyType: concurrenyType)
        childManagedObjectContext.parent = mainObjectContext
        childManagedObjectContext.mergePolicy = NSMergePolicy(merge: mergePolicyType)
        
        return childManagedObjectContext
        
    }
    
}
