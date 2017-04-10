//
//  StoreType.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import Foundation
import CoreData

//// Persistent Store Stype used
public enum StoreType {
    
    // SQL based store type, associtaed with store url
    case sqLite (URL)
    
    // Binary Store Type Used , associated with url
    case binary (URL)
    
    // in memory store type
    case inMemory
    
    
    // MARK: - Methods
    
    // Get type of store
    //
    // returns: The type of store description
    public var type: String {
        switch self {
        case .sqLite: return NSSQLiteStoreType
        case .binary: return NSBinaryStoreType
        case .inMemory: return NSInMemoryStoreType
        }
    }
    
    
    // Get URL of store
    //
    // returns: The file url of directory where store is located
    public func storeDirectory() -> URL? {
        switch self {
        case let .sqLite(url): return url
        case let .binary(url): return url
        case .inMemory: return nil
        }
    }
    
    
}
