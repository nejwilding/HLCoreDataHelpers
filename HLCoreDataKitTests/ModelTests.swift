//
//  ModelTests.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 21/09/2015.
//  Copyright © 2015 Nicholas Wilding. All rights reserved.
//

import XCTest
@testable import ExampleModel
@testable import HLCoreDataHelpers

class ModelTests: XCTestCase {
    
    var model: CoreDataModel!
    
    override func setUp() {
        super.setUp()
        
        model = CoreDataModel(modelVersion: ModelVersion.version1)
    }
    
    override func tearDown() {
        model = nil
        super.tearDown()
    }
    

    func testModelDetails() {
        
        let version = ModelVersion.version1
        
        XCTAssert(model.modelVersion.modelName == version.modelName, "Model name should equal model setting")
        XCTAssert(model.modelVersion.modelBundle == version.modelBundle , "Should default to main bundle")

        XCTAssertNotNil(model.storeURL)
        
        let storeComponents = model.storeURL!.pathComponents
        XCTAssertEqual(String(storeComponents.last!), model.databaseFileName)
        XCTAssertEqual(String(storeComponents[storeComponents.count - 2]), "Documents")
        
        let modelURLComponents = model.modelVersion.modelURL.pathComponents
        XCTAssertEqual(String(modelURLComponents.last!), modelName + ".momd")
        
        
        // THEN: the managed object model does not assert
        XCTAssertNotNil(model.modelVersion.managedObjectModel)
        
        // THEN: the store doesn't need migration
        //XCTAssertFalse(model.needsMigration)
        
    }
    
}
