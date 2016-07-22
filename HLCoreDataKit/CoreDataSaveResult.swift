//
//  CoreDataSaveResult.swift
//  HLCoreDataHelpers
//
//  Created by Nicholas Wilding on 20/07/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import Foundation

/// A result of the Core Data Save on NSManagedObjectContext
public enum CoreDataSaveResult: Equatable {
    
    /// Success result
    case success
    
    // Failed result with NSError to describe error
    case failure(NSError)

}

// MARK: - Methods

extension CoreDataSaveResult {
    
    /**
    - Returns: The results NSError if failed, otherwise nil
    */
    public func error() -> NSError? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
    
}

// MARK: - Delegate: CustomStringConvertable

extension CoreDataSaveResult: CustomStringConvertible {
    
    /// description
    public var description: String {
        get {
            var str = "<\(CoreDataSaveResult.self):"
            switch self {
            case .success:
                str += ".Success"
            case .failure(let error):
                str += ".Failure \(error)"
            }
            return str + ">"
        }
    }
}


// MARK: - Equatable

public func ==(lhs: CoreDataSaveResult, rhs: CoreDataSaveResult) -> Bool {
    switch(lhs, rhs) {
    case (.success, .success):
        return true
    case (let .failure(error1), let .failure(error2)):
        return error1 == error2
    default:
        return false
    }
}

