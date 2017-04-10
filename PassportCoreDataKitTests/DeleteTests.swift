//
//  DeleteTests.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import XCTest
import CoreData
import ExampleModel
@testable import HLCoreDataHelpers

class DeleteTests: TestBuilds {

    func test_ThatDelete_Succeeds_WithManyObjects() {
        
        let stack = self.dataStack!
        
        let count = 10
        let predicateValue = 6
        let objects = generatePersonObjects(withCount: count)
        
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        guard let results = try? stack.mainObjectContext.fetch(request) else {
            fatalError("Resluts could not be unwrapped")
        }

        
        XCTAssertEqual(results.count, predicateValue, "Fetch request should return \(predicateValue) objects")
        
        // delete objects
        stack.mainObjectContext.deleteObjects(objects)
        
        // get results again
        guard let resultsAfterDelete = try? stack.mainObjectContext.fetch(request) else {
            XCTFail("Results could not be unwrapped"); return
        }

        
        XCTAssertEqual(resultsAfterDelete.count, 0, "Fetch request should return 0 objects")
        
        XCTAssertTrue(stack.mainObjectContext.hasChanges)
        
        let saveExpectation = expectation(description: "SaveExpected")
        
        // when - attempting save
        stack.mainObjectContext.saveInContext { (result) in
            XCTAssertTrue(result == .success, "Save should not show error")
            saveExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: { (error) -> Void in
            XCTAssertNil(error, "Error should be nil")
        })
    }

    func test_ThatDelete_Succeeds_WithSingleObject() {
        
        // given
        let count = 10
        let predicateValue = 6

        let stack = self.dataStack!
        _ = generatePersonObjects(withCount: count)
        let myPerson = Person.insertIntoContext(stack.mainObjectContext, firstname: "Charles", surname: "Wilson", age: 10, gender: "male")
        
        // when
        let predicate = NSPredicate(format: "%K == [c]%@", Person.Keys.firstname.rawValue, myPerson.firstname!)
        let requestSingleObject: NSFetchRequest<Person> = Person.sortedFetchRequest(withPredicate: predicate)
        
        guard let results = try? stack.mainObjectContext.fetch(requestSingleObject) else {
            XCTFail("Results could not be unwrapped"); return
        }
        XCTAssertEqual(results.count, 1, "Fetch should return just one result")
        
        // delete object
        stack.mainObjectContext.deleteObjects([myPerson])
        
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        guard let resultsAfterDelete = try? stack.mainObjectContext.fetch(request) else {
            XCTFail("Results could not be unwrapped"); return
        }

        
        XCTAssertEqual(resultsAfterDelete.count, predicateValue, "New results count should equal \(count )")
        
        guard let resultOfObjectAfterDelete = try? stack.mainObjectContext.fetch(requestSingleObject) else {
            XCTFail("Results could not be unwrapped"); return
        }

        
        XCTAssertEqual(resultOfObjectAfterDelete.count, 0, "Predicate Fetch should now return 0 results")

    }
    
    
    func test_ThatDelete_Succeeds_WithEmptyObjects() {
        
        let stack = self.dataStack!
        
        stack.mainObjectContext.deleteObjects([])
        
        XCTAssertFalse(stack.mainObjectContext.hasChanges)
        
    }

}
