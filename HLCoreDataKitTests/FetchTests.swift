//
//  FetchTests.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import XCTest
import ExampleModel

@testable import HLCoreDataKit

class FetchTests: TestBuilds {
    
    func test_ThatFetchRequests_Success_WithManyObjects() {
        
        let stack = self.dataStack
        
        let count = 10
        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
        
        let request = Person.sortedFetchRequest
        print(request)
        //request.fetchBatchSize = 10
        let results = try! stack.mainObjectContext.executeFetchRequest(request)
        
        XCTAssertEqual(results.count, count, "Fetch should return \(count) objects")
        stack.mainObjectContext.saveContext() { result in
            XCTAssertTrue(result.success == true, "Should return as a success")
        }
    }
    
    func test_ThatFetchRequest_Succeeds_WithObject() {
        
        let stack = self.dataStack
        let count = 10
        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
        
        let myPerson = Person.insertIntoContext(stack.mainObjectContext, firstname: "Charles", surname: "Wilson", age: 12, gender: "male")
        
        let request = Person.sortedFetchRequest
        request.predicate = Predicate(format: "%K == [n]%@", Person.Keys.firstname.rawValue, myPerson.firstname!)
        
        let results = try! stack.mainObjectContext.executeFetchRequest(request)
        
        XCTAssertEqual(results.count, 1, "Fetch should return just one result")
    }
    
    func test_ThatFetchRequest_Succeeds_WithoutObjects() {
        let stack = self.dataStack
        
        let request = Person.sortedFetchRequest
        let results = try! stack.mainObjectContext.executeFetchRequest(request)
        
        XCTAssertEqual(results.count, 0, "Fetch reesults should equal 0")
    }
    
    func test_ThatFetchRequest_Succeeds_WithFetchLimit() {
        
        let stack = self.dataStack
        
        let count = 10
        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
        
        let request = Person.sortedFetchRequest
        request.fetchBatchSize = 5
        request.fetchLimit = 5
        
        let results = try! stack.mainObjectContext.executeFetchRequest(request)
        
        XCTAssertEqual(results.count, 5, "Fetch should return \(5) results")
        
    }
    
    func test_ThatFetchRequest_Succeeds_WithSortascending() {
        
        let stack = self.dataStack
        
        let count = 10
        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
        
        let request = Person.sortedFetchRequest
        
        let results = try! stack.mainObjectContext.executeFetchRequest(request)
    
        XCTAssertEqual(results.first?.gender, "female", "Fetch should sort ascending and show Female first")
    }

    func test_ThatFetchRequest_Suceeds_OnCount() {
        let stack = self.dataStack
        
        let count = 10
        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
        
        let fetchCount = 5
        let request = Person.sortedFetchRequest
        request.fetchLimit = 5
        let resultCount = try! stack.mainObjectContext.fetchCount(request)
        
        XCTAssertEqual(resultCount, fetchCount, "Fetch should return \(fetchCount) results")
    }
    
}
