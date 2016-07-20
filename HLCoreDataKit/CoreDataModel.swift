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
public typealias SeedSaveResult = (success: Bool, error: NSError?)

/// A Core Data Model representing a given Data Model
/// Provides the name, its bundle and the store url

public struct CoreDataModel {
    
    let name: String
    let bundle: Bundle
    let storeType: StoreType
    
    // MARK: - Properties
    
    //database file
    public var databaseFileName: String {
        get {
            switch storeType {
            case .sqLite: return "\(name).sqlite"
            default: return name
            }
            
        }
    }
    
    // store url
    public var storeURL: URL? {
        get {
           return try! storeType.storeDirectory()?.appendingPathComponent(databaseFileName)
        }
    }
    
    // model url found by model name
    public var modelURL: URL {
        
        get {
            guard let url = bundle.urlForResource(name, withExtension: "momd") else {
                fatalError("*** Error loading model URL for model named \(name) bundle: \(bundle.bundleIdentifier)")
            }
            return url
        }
    }
    
    
    // managed object model from modelurl
    public var managedObjectModel: NSManagedObjectModel {
        return NSManagedObjectModel(contentsOf: modelURL)!
    }
    
    /// Creates new model with specified name and bundle
    ///
    /// :param: name                Name of model of CoreData
    /// :param: bundle              NSBundle where model is located
    ///                             Default - MainBundle
    /// :param: storeDirectoryURL   Directory in which model is located
    ///                             Defaults to document directory
   public init(name: String, bundle: Bundle = Bundle.main, storeType: StoreType = .sqLite(applicationDocumentsDirectory()) ) {
        self.name = name
        self.bundle = bundle
        self.storeType = storeType
    
    }
    
    
    // MARK: - Seed Data
    
    /// Create new model data from seed file if not in existence
    ///
    /// :param: name        Name of seed file
    /// :parma: completion  Closure block returning results of success or failure
    public func seedExistingModelStore(_ name: String, completion:(SeedSaveResult) -> Void) {
        
        guard let storeURL = storeURL else {
            return
        }
        
       if !FileManager.default.fileExists(atPath: storeURL.path!) {

            let preloadPath = Bundle.main.pathForResource(name, ofType: "sqlite")
            
            do {
                try FileManager.default.copyItem(atPath: preloadPath!, toPath: storeURL.path!)
                completion((true, nil))
            } catch let error as NSError? {
                completion((false, error))
            }
        }
    }
    
    
    
}

// MARK: - Private Function

private func applicationDocumentsDirectory() -> URL {
    
    do {
        return try FileManager.default.urlForDirectory(
            .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true)
    } catch {
        fatalError("***** Error find documents directory")
    }
    
}




