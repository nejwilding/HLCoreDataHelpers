//
//  ModelUtility.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import Foundation
@testable import HLCoreDataHelpers

public let modelName = "ExampleModel"
public let modelBundle =  Bundle(identifier: "cherrycoda.ExampleModel")!



enum ModelVersion: String {
    case version1 = "ExampleModel"
}

extension ModelVersion: ModelVersionType {
    
    var modelName: String {
        return rawValue
    }
    
    var modelBundle: Bundle {
        return Bundle(identifier: "cherrycoda.ExampleModel")!
    }
}
