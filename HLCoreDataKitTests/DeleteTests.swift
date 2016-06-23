//
//  DeleteTests.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import XCTest
import ExampleModel

@testable import HLCoreDataKit

class DeleteTests: TestBuilds {

//    func test_ThatDelete_Succeeds_WithManyObjects() {
//        
//        let dataStack = self.dataStack
//        
//        let count = 10
//        let objects = generatePersonObjectsInContext(dataStack.mainObjectContext, count: count)
//        
//        let request = FetchRequest(entity: entity(name: Person.modelEntityName, context: dataStack.mainObjectContext))
//        let results = try! dataStack.mainObjectContext.fetch(request)
//        
//        XCTAssertEqual(results.count, 10, "Fetch request should return \(count) objects")
//        
//        // delete objects
//        dataStack.mainObjectContext.deleteObjects(objects)
//        
//        // get results again
//        let resultsAfterDelete = try! dataStack.mainObjectContext.fetch(request)
//        
//        XCTAssertEqual(resultsAfterDelete.count, 0, "Fetch request should return 0 objects")
//        
//        XCTAssertTrue(dataStack.mainObjectContext.hasChanges)
//        
//        dataStack.mainObjectContext.saveContext() { result in
//            XCTAssertTrue(result.success == true, "Should return positive rusults")
//        }
//    }
//    
//    func test_ThatDelete_Succeeds_WithObject() {
//        
//        let stack = self.dataStack
//        let count = 10
//        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
//        let myPerson = Person.newPerson(stack.mainObjectContext, firstname: "Charles", surname: "Wilson", age: 12, gender: "male")
//        
//        let requestForObject = FetchRequest<Person>(entity: entity(name: Person.modelEntityName, context: stack.mainObjectContext))
//        requestForObject.predicate = NSPredicate(format: "firstname == %@", myPerson.firstname!)
//        
//        let results = try! stack.mainObjectContext.fetch(requestForObject)
//        XCTAssertEqual(results.count, 1, "Fetch should return just one result")
//        
//        // delete object
//        stack.mainObjectContext.deleteObjects([myPerson])
//        
//        let request = FetchRequest(entity: entity(name: Person.modelEntityName, context: stack.mainObjectContext))
//        let resultsAfterDelete = try! stack.mainObjectContext.fetch(request)
//        
//        XCTAssertEqual(resultsAfterDelete.count, count, "New results count should equal \(count )")
//        
//        let resultOfObjectAfterDelete = try! stack.mainObjectContext.fetch(requestForObject)
//        
//        XCTAssertEqual(resultOfObjectAfterDelete.count, 0, "Predicate Fetch should now return 0 results")
//
//    }
//    
//    
//    func test_ThatDelete_Succeeds_WithEmptyObjects() {
//        
//        let stack = self.dataStack
//        
//        stack.mainObjectContext.deleteObjects([])
//        
//        XCTAssertFalse(stack.mainObjectContext.hasChanges)
//        
//    }

}
