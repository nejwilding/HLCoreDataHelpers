//
//  DataStackTests.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import XCTest
import CoreData
import ExampleModel
@testable import HLCoreDataHelpers

class DataStackTests: XCTestCase {

    override func setUp() {
        super.setUp()
     
    }
    
    override func tearDown() {
   
        super.tearDown()
    }

    func test_ThatSQLStack_InitializesSuccessfully() {
        
        let sqlModel = CoreDataModel(name: modelName, bundle: modelBundle)
        
        let dataStack = CoreDataStack(model: sqlModel)
        XCTAssertNotNil(dataStack)
        XCTAssertEqual(dataStack.mainObjectContext.concurrencyType, NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType, "Main context should be primary context")
        
    }
    
    func test_ThatInMemoryStack_InitializesSuccessfully() {
        let inMemoryModel = CoreDataModel(name: modelName, bundle: modelBundle, storeType:  StoreType.inMemory)
        
        let dataStack = CoreDataStack(model: inMemoryModel)
        XCTAssertNotNil(dataStack)
        XCTAssertEqual(dataStack.mainObjectContext.concurrencyType, NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType, "Main context should be primary context")
        
    }


}

