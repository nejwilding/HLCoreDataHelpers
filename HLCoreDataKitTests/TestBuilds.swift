//
//  TestBuilds.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import XCTest
import CoreData
import ExampleModel

@testable import HLCoreDataKit

class TestBuilds: XCTestCase {
    
    let inMemoryModel = CoreDataModel(name: modelName, bundle: modelBundle, storeType: .InMemory)
    
    var dataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        
        dataStack = CoreDataStack(model: inMemoryModel)
        
    }
    
    override func tearDown() {
       
        dataStack = nil
        super.tearDown()
    }
    
    func generatePersonObjectsInContext(_ context: NSManagedObjectContext, count: Int) -> [Person] {
        var people = [Person]()
        
        let half = count / 2
        for _ in 0..<half {
            
            let p = Person.insertIntoContext(context,
                    firstname: "Mike",
                    surname: "Jones",
                    age: 10,
                    gender: "male")
                
                print("xxxx \(p)")
                people.append(p)

        }
        
        for _ in 0..<half {
            
            let p = Person.insertIntoContext(context,
                    firstname: "Shauna",
                    surname: "Collett",
                    age: 10,
                    gender: "female")
                people.append(p)

        }
        
        print("XXXX \(people)")
        return people
    }

    
}



