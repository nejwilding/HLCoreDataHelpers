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
        _ = generatePersonObjects(withCount: count)
        
        // when
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        guard let results = try? stack.mainObjectContext.fetch(request) else {
            XCTFail("Results could not be unwrapped"); return
        }
        
        // then
        let predicateCount = 6
        XCTAssertEqual(results.count, predicateCount, "Fetch should return \(count) objects")

    }
    
    func test_ThatFetchRequest_Succeeds_WithObject() {
        // given
        let stack = self.dataStack!
        let count = 10
        _ = generatePersonObjects(withCount: count)
        
        let myPerson = Person.insertIntoContext(stack.mainObjectContext, firstname: "Charles",
                                                    surname: "Wilson", age: 10, gender: "male")
        stack.mainObjectContext.saveInContext()
        
        // when
        let predicate = NSPredicate(format: "%K == [c]%@", Person.Keys.firstname.rawValue, myPerson.firstname!)
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest(withPredicate: predicate)
        
        guard let results = try? stack.mainObjectContext.fetch(request) else {
            XCTFail("Results could not be unwrapped"); return
        }
        
        // then
        XCTAssertEqual(results.count, 1, "Fetch should return just one result")
    }
    
    func test_ThatFetchRequest_Succeeds_WithoutObjects() {
        // given
        let stack = self.dataStack!

        // when
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        guard let results = try? stack.mainObjectContext.fetch(request) else {
            XCTFail("Results could not be unwrapped"); return
        }
        
        // then
        XCTAssertEqual(results.count, 0, "Fetch reesults should equal 0")
    }
    
    func test_ThatFetchRequest_Succeeds_WithFetchLimit() {
        // given
        let stack = self.dataStack!
        let count = 10
        _ = generatePersonObjects(withCount: count)
        
        // when
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        request.fetchBatchSize = 5
        request.fetchLimit = 5
        
        guard let results = try? stack.mainObjectContext.fetch(request) else {
            XCTFail("Results could not be unwrapped"); return
        }
        
        // then
        XCTAssertEqual(results.count, 5, "Fetch should return \(5) results")
    }
    
    func test_ThatFetchRequest_Succeeds_WithSortascending() {
        // given
        let stack = self.dataStack!
        let count = 10
        _ = generatePersonObjects(withCount: count)
        
        // when
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        guard let results = try? stack.mainObjectContext.fetch(request) else {
            XCTFail("Results could not be unwrapped"); return
        }
    
        // then
        XCTAssertEqual(results.first?.gender, "female", "Fetch should sort ascending and show Female first")
    }

    func test_ThatFetchRequest_Suceeds_OnCount() {
        // given
        let stack = self.dataStack!
        
        let count = 10
        _ = generatePersonObjects(withCount: count)
        
        // when
        let fetchCount = 5
        let request: NSFetchRequest<Person> = Person.sortedFetchRequest()
        request.fetchLimit = 5
        guard let results = try? stack.mainObjectContext.fetch(request) else {
            XCTFail("Results could not be unwrapped"); return
        }
        
        // then
        XCTAssertEqual(results.count, fetchCount, "Fetch should return \(fetchCount) results")
    }
    
}
