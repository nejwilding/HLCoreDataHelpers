//
//  TestBuilds.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import XCTest
import CoreData
@testable import ExampleModel
@testable import HLCoreDataHelpers

class TestBuilds: XCTestCase {
    
    var dataStack: CoreDataStack! = nil
    
    override func setUp() {
        super.setUp()
        let inMemoryModel = CoreDataModel(name: modelName, bundle: modelBundle, storeType: StoreType.inMemory)
        dataStack = CoreDataStack(model: inMemoryModel)
        
    }
    
    override func tearDown() {
        dataStack = nil
        super.tearDown()
    }
    
    func generatePersonObjects(withCount count: Int) -> [Person] {
        var people: [Person] = []
        
        let third = count / 3
        for _ in 0..<third {

            let p = Person.insertIntoContext(dataStack.mainObjectContext,
                    firstname: "Mike",
                    surname: "Jones",
                    age: 10,
                    gender: "male")
            people.append(p)

        }
        
        for _ in 0..<third {
            
            let p = Person.insertIntoContext(dataStack.mainObjectContext,
                    firstname: "Shauna",
                    surname: "Collett",
                    age: 10,
                    gender: "female")
                people.append(p)
        }
        
        for _ in 0..<third {
            
            let p = Person.insertIntoContext(dataStack.mainObjectContext,
                                             firstname: "Maria",
                                             surname: "Sanders",
                                             age: 5,
                                             gender: "female")
            people.append(p)
        }
        
        return people
    }

    
}
