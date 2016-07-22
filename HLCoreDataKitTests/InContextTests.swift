//
//  InContextTests.swift
//  HLCoreDataHelpers
//
//  Created by Nicholas Wilding on 22/07/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import XCTest
import CoreData
@testable import ExampleModel
@testable import HLCoreDataHelpers

class InContextTests: TestBuilds {
    
    func testThat_FetchInContext_Returns() {
        // given
        let stack = self.dataStack!
        let count = 10
        _ = generatePersonObjects(count: count)
        
        let myPerson = Person.insertIntoContext(stack.mainObjectContext, firstname: "Charles", surname: "Wilson", age: 10, gender: "male")
        stack.mainObjectContext.saveInContext()
        
        // when
        let predicate = Predicate(format: "%K == [c]%@", Person.Keys.firstname.rawValue, myPerson.firstname!)
        
        let matches = Person.fetch(inContext:stack.mainObjectContext) { request in
            request.predicate = predicate
        }
        
        // then
        XCTAssertEqual(matches.count, 1)
    }
    
    func testThat_FetchCount_ReturnsValue() {
        // given
        let stack = self.dataStack!
        let count = 10
        _ = generatePersonObjects(count: count)
        
        let myPerson = Person.insertIntoContext(stack.mainObjectContext, firstname: "Charles", surname: "Wilson", age: 10, gender: "male")
        stack.mainObjectContext.saveInContext()
        
        // when
        let predicate = Predicate(format: "%K == [c]%@", Person.Keys.firstname.rawValue, myPerson.firstname!)
        
        let returnCount = Person.count(inContext:stack.mainObjectContext) { request in
            request.predicate = predicate
        }
        
        // then
        XCTAssertEqual(returnCount, 1)
    }
    
    func testThat_LastModified_ReturnsValue() {
        // given
        let stack = self.dataStack!
        let count = 10
        _ = generatePersonObjects(count: count)
        
        let myPerson = Person.insertIntoContext(stack.mainObjectContext, firstname: "Charles", surname: "Wilson", age: 10, gender: "male")
        stack.mainObjectContext.saveInContext()
        
        // when
        let predicate = Predicate(format: "%K == [c]%@", Person.Keys.firstname.rawValue, myPerson.firstname!)
        
        let result = Person.lastModified(inContext:stack.mainObjectContext) { request in
            request.predicate = predicate
        }
        
        // then
        XCTAssertNotNil(result)
    }
    
}
