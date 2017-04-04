//
//  CoreDataModel.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 18/06/2015.
//  Copyright (c) 2015 Nicholas Wilding. All rights reserved.
//

import Foundation
import CoreData

// Alias for Seed result
public typealias SeedSaveResult = (success: Bool, error: Error?)

/// A Core Data Model representing a given Data Model
/// Provides the name, its bundle and the store url
public struct CoreDataModel {
    
    // MARK: - Properties
    
    /// The name of the Core Data model resource.
    public let name: String
    
    /// The bundle in which the model is located.
    public let bundle: Bundle
    
        /// The type of the Core Data persistent store for the model.
    let storeType: StoreType

    /// database file
    public var databaseFileName: String {
        switch storeType {
        case .sqLite: return "\(name).sqlite"
        default: return name
        }
    }
    
    // model url found by model name
    public var modelURL: URL {
        guard let url = bundle.url(forResource: name, withExtension: "momd") else {
            let desc = String(describing: bundle.bundleURL)
            fatalError("*** Error loading model URL for model named \(name) bundle: \(desc)")
        }
        return url
    }
    
    /// The managed object model for the model specified by `name`.
    public var managedObjectModel: NSManagedObjectModel {
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("*** Error loading managed object model at url: \(modelURL)")
        }
        return model
    }

    
    /// store url
    public var storeURL: URL? {
        return storeType.storeDirectory()?.appendingPathComponent(databaseFileName)
    }

    /**
     Creates new model with specified name and bundle
 
     - Parameter modelVersion:        Model details such as name
 
     - Parameter storeDirectoryURL:   Directory in which model is located - Defaults to document directory
    */
    public init(name: String, bundle: Bundle = Bundle.main, storeType: StoreType = .sqLite (applicationDocumentsDirectory()) ) {
            self.name = name
            self.bundle = bundle
            self.storeType = storeType
    }

    
    
    
    // MARK: - Seed Data
    
    /**
     Create new model data from seed file if not in existence
   
     - Parameter name"        Name of seed file
     - Parameter completion"  Closure block returning results of success or failure
     */
    public func seedExistingModelStore(_ name: String, completion: (SeedSaveResult) -> Void) {
        
        guard let storeURL = storeURL else {
            return
        }
        
       if !FileManager.default.fileExists(atPath: storeURL.path) {

            let preloadPath = Bundle.main.path(forResource: name, ofType: "sqlite")
            
            do {
                try FileManager.default.copyItem(atPath: preloadPath!, toPath: storeURL.path)
                completion((true, nil))
            } catch let error as Error? {
                completion((false, error))
            }
        }
    }
  
}

// MARK: - Private Function

private func applicationDocumentsDirectory() -> URL {
    
    do {
        return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                           appropriateFor: nil, create: true)
    } catch {
        fatalError("***** Error find documents directory")
    }
    
}
