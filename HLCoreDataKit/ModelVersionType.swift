//
//  ModelVersionType.swift
//  HLCoreDataHelpers
//
//  Created by Nicholas Wilding on 20/07/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import Foundation
import CoreData

public protocol ModelVersionType {
    var modelName: String { get }
    var modelBundle: Bundle { get }
}

extension ModelVersionType {
    
    var modelBundle: Bundle {
        return Bundle.main
    }
    
    // managed object model from modelurl
    public var managedObjectModel: NSManagedObjectModel {
        return NSManagedObjectModel(contentsOf: modelURL)!
    }
    
    // model url found by model name
    public var modelURL: URL {
        guard let url = modelBundle.url(forResource: modelName, withExtension: "momd") else {
            let desc = String(describing: modelBundle.bundleIdentifier)
            fatalError("*** Error loading model URL for model named \(modelName) bundle: \(desc)")
        }
        return url
    }
    
}
