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
    
    let storeType: StoreType
    let modelVersion: ModelVersionType

    //database file
    public var databaseFileName: String {
        switch storeType {
        case .sqLite: return "\(modelVersion.modelName).sqlite"
        default: return modelVersion.modelName
        }
    }

    
    // store url
    public var storeURL: URL? {
        return storeType.storeDirectory()?.appendingPathComponent(databaseFileName)
    }

    /**
     Creates new model with specified name and bundle
 
     - Parameter modelVersion:        Model details such as name
 
     - Parameter storeDirectoryURL:   Directory in which model is located - Defaults to document directory
    */
    public init(modelVersion: ModelVersionType, storeType: StoreType = .sqLite(applicationDocumentsDirectory())) {
        self.storeType = storeType
        self.modelVersion = modelVersion
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
