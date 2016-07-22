//
//  SaveTests.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 02/02/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import XCTest
import CoreData
@testable import HLCoreDataHelpers

class SaveTests: TestBuilds {
    
    func test_ThatSave_WithChanges_Succeeds() {
        
        let stack = self.dataStack!
        
        _ = generatePersonObjects(count: 3)
        
        var didSaveMain = false
        
        expectation(forNotification: NSNotification.Name.NSManagedObjectContextDidSave.rawValue, object: stack.mainObjectContext) { (notification) -> Bool in
            didSaveMain =  true
            return true
        }
        
        let saveExpectation = expectation(description: "SaveExpected")
        
        // when - attempting save
        stack.mainObjectContext.saveInContext { (result) in
            XCTAssertTrue(result == .success, "Save should not show error")
            saveExpectation.fulfill()
        }
                
        waitForExpectations(timeout: 5.0, handler: { (error) -> Void in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertTrue(didSaveMain)
            
        })
    }

    
    func test_ThatSave_WithoutChanges_Succeeds() {
        
        let stack = self.dataStack!
        var didCallCompletion  = false
        
        stack.mainObjectContext.perform { result in
            didCallCompletion = true
        }
        
        XCTAssertFalse(didCallCompletion, "Should not complete and be false")
    }

    
}
