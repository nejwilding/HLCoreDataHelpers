//
//  FetchTests.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import XCTest
import CoreData
@testable import ExampleModel
@testable import HLCoreDataHelpers

class FetchTests: TestBuilds {
    
    func test_ThatFetchRequests_Success_WithManyObjects() {
        // given
        let stack = self.dataStack!
        let count = 10
        _ = generatePersonObjects(count: count)
        
        // when
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        print(request)
        let results = try! stack.mainObjectContext.fetch(request)
        
        // then
        let predicateCount = 6
        XCTAssertEqual(results.count, predicateCount, "Fetch should return \(count) objects")
        stack.mainObjectContext.saveOrRollback() { result in
            XCTAssertTrue(result.success == true, "Should return as a success")
        }
    }
    
    func test_ThatFetchRequest_Succeeds_WithObject() {
        // given
        let stack = self.dataStack!
        let count = 10
        _ = generatePersonObjects(count: count)
        
        let myPerson = Person.insertIntoContext(stack.mainObjectContext, firstname: "Charles", surname: "Wilson", age: 12, gender: "male")
        
        // when
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        request.predicate = Predicate(format: "%K == [n]%@", Person.Keys.firstname.rawValue, myPerson.firstname!)
        
        let results = try! stack.mainObjectContext.fetch(request)
        
        // then
        XCTAssertEqual(results.count, 1, "Fetch should return just one result")
    }
    
    func test_ThatFetchRequest_Succeeds_WithoutObjects() {
        // given
        let stack = self.dataStack!

        // when
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        let results = try! stack.mainObjectContext.fetch(request)
        
        // then
        XCTAssertEqual(results.count, 0, "Fetch reesults should equal 0")
    }
    
    func test_ThatFetchRequest_Succeeds_WithFetchLimit() {
        // given
        let stack = self.dataStack!
        let count = 10
        _ = generatePersonObjects(count: count)
        
        // when
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        request.fetchBatchSize = 5
        request.fetchLimit = 5
        
        let results = try! stack.mainObjectContext.fetch(request)
        
        // then
        XCTAssertEqual(results.count, 5, "Fetch should return \(5) results")
    }
    
    func test_ThatFetchRequest_Succeeds_WithSortascending() {
        // given
        let stack = self.dataStack!
        let count = 10
        _ = generatePersonObjects(count: count)
        
        // when
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        
        let results = try! stack.mainObjectContext.fetch(request)
    
        // then
        XCTAssertEqual(results.first?.gender, "female", "Fetch should sort ascending and show Female first")
    }

    func test_ThatFetchRequest_Suceeds_OnCount() {
        // given
        let stack = self.dataStack!
        
        let count = 10
        _ = generatePersonObjects(count: count)
        
        // when
        let fetchCount = 5
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        request.fetchLimit = 5
        let resultCount = try! stack.mainObjectContext.fetch(request)
        
        // then
        XCTAssertEqual(resultCount.count, fetchCount, "Fetch should return \(fetchCount) results")
    }
    
}
