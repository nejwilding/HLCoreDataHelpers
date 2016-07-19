//
//  SaveTests.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 02/02/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import XCTest
import CoreData

class SaveTests: TestBuilds {
    
    func test_ThatSave_WithChanges_Succeeds() {
        
        let stack = self.dataStack
        
        generatePersonObjectsInContext(stack.mainObjectContext, count: 3)
        
        var didSaveMain = false
        expectationForNotification(NSNotification.Name.NSManagedObjectContextDidSave, object: stack.mainObjectContext) { (notification) -> Bool in
            didSaveMain =  true
            return true
        }
        
        var didSavePrivate = false
        expectationForNotification(NSNotification.Name.NSManagedObjectContextDidSave, object: stack.writerObjectContext) { (notification) -> Bool in
            didSavePrivate =  true
            return true
        }
        
        stack.mainObjectContext.saveContext()
        
        waitForExpectations(withTimeout: 5.0, handler: { (error) -> Void in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertTrue(didSaveMain)
            XCTAssertTrue(didSavePrivate)
            
        })
    }

    
    func test_ThatSave_WithoutChanges_Suceeds() {
        
        let stack = self.dataStack
        var didCallCompletion  = false
        
        stack.mainObjectContext.saveContext() { result in
            didCallCompletion = true
        }
        
        XCTAssertFalse(didCallCompletion, "Should not complete and be false")
        
    
    }

    
}
