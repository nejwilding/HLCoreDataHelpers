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
        
        model = CoreDataModel(name: modelName, bundle: modelBundle)
    }
    
    override func tearDown() {
        model = nil
        super.tearDown()
    }
    

    func testModelDetails() {
        
        XCTAssert(model.name == modelName, "Model name should equal model setting")
        XCTAssert(model.bundle == modelBundle, "Should default to main bundle")

        XCTAssertNotNil(model.storeURL)
        
        let storeComponents = model.storeURL!.pathComponents
        XCTAssertEqual(String(storeComponents.last!), model.databaseFileName)
        XCTAssertEqual(String(storeComponents[storeComponents.count - 2]), "Documents")
        
        let modelURLComponents = model.modelURL.pathComponents
        XCTAssertEqual(String(modelURLComponents.last!), modelName + ".momd")
        
        
        // THEN: the managed object model does not assert
        XCTAssertNotNil(model.managedObjectModel)
        
        // THEN: the store doesn't need migration
        //XCTAssertFalse(model.needsMigration)
        
    }
    
}
