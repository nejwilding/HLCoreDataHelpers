//
//  FetchedResultsTests.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 06/02/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

//import XCTest
//import ExampleModel
//@testable import HLCoreDataHelpers
//
//class FetchedResultsTests: TestBuilds {
//    
//    
//    
//    
//    func test_ThatFetchedResultsController_Exists() {
//        
//        let stack = self.dataStack
//        
//        let count = 10
//        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
//
//        let request = Person
////        
////        let request = FetchRequest<Person>(entity: entity(name: Person.modelEntityName, context: stack.mainObjectContext), sorts: [sortDescriptor(key: "gender", ascending: false )])
//        
//        let resultsController = FetchedResultsController(request: request, inContext: stack.mainObjectContext)
//        
//        XCTAssertNotNil(resultsController)
//    }
//
//    
//    func test_ThatFetchedResultsController_Succeeds_WithNumberOfSections() {
//        
//        let stack = self.dataStack
//        
//        let count = 10
//        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
//        let request = FetchRequest<Person>(entity: entity(name: Person.modelEntityName, context: stack.mainObjectContext), sorts: [sortDescriptor(key: "gender", ascending: false )])
//        
//        let resultsController = FetchedResultsController(request: request, inContext: stack.mainObjectContext, bySection: "gender")
//        
//        XCTAssertEqual(resultsController.numberOfSections(), 2, "Should return 2 sections")
//      
//    }
//    
//    func test_ThatFetchedResultsController_Succeeds_WithObjectInSection() {
//        
//        let stack = self.dataStack
//        
//        let count = 10
//        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
//        let request = FetchRequest<Person>(entity: entity(name: Person.modelEntityName, context: stack.mainObjectContext), sorts: [sortDescriptor(key: "gender", ascending: false )])
//        
//        let resultsController = FetchedResultsController(request: request, inContext: stack.mainObjectContext, bySection: "gender")
//        
//        XCTAssertEqual(resultsController.numberOfRowsInSection(0), 5, "Should return 5 in secion 1")
//        
//    }
//    
//    
//    func test_ThatFetchedResultsController_Succeeds_WithNumberOfObjects() {
//        let stack = self.dataStack
//        
//        let count = 10
//        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
//        let request = FetchRequest<Person>(entity: entity(name: Person.modelEntityName, context: stack.mainObjectContext), sorts: [sortDescriptor(key: "gender", ascending: false )])
//        
//        let resultsController = FetchedResultsController(request: request, inContext: stack.mainObjectContext, bySection: "gender")
//        
//        XCTAssertEqual(resultsController.numberOfObjects(), count, "Should return \(count) objects")
//    }
//    
//    
//    func test_ThatFetchedResultController_Succeeds_WithSectionTitle() {
//        let stack = self.dataStack
//        
//        let count = 10
//        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
//        let request = FetchRequest<Person>(entity: entity(name: Person.modelEntityName, context: stack.mainObjectContext), sorts: [sortDescriptor(key: "gender")])
//        
//        let resultsController = FetchedResultsController(request: request, inContext: stack.mainObjectContext, bySection: "gender")
//        
//        XCTAssertEqual(resultsController.sectionTitle(0), "female", "Should return female")
//    }
//    
//    
//    func test_ThatFetchedResultsController__Succeeds_WithObjectAtIndex() {
//        let stack = self.dataStack
//        
//        let count = 10
//        generatePersonObjectsInContext(stack.mainObjectContext, count: count)
//        let request = FetchRequest<Person>(entity: entity(name: Person.modelEntityName, context: stack.mainObjectContext), sorts: [sortDescriptor(key: "gender")])
//        
//        let resultsController = FetchedResultsController(request: request, inContext: stack.mainObjectContext, bySection: "gender")
//        
//        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
//        XCTAssertNotNil(resultsController.objectAtIndexPath(indexPath), "Should return valid object")
//        
//        let person = resultsController.objectAtIndexPath(indexPath) as! Person
//        XCTAssertTrue(person.isKindOfClass(Person) ==  true, "Should be valid person")
//        
//    }
    
//}
