//
//  Person.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import Foundation
import CoreData


public class Person: NSManagedObject {
    
    internal static let modelEntityName = String(self)

    private convenience init(context: NSManagedObjectContext,
        firstname: String,
        surname: String,
        age: Int,
        gender: String) {
            
            let entity = NSEntityDescription.entityForName(Person.modelEntityName, inManagedObjectContext: context)!
            
            self.init(entity: entity, insertIntoManagedObjectContext: context)
            
            self.firstname = firstname
            self.surname = surname
            self.age = age
            self.gender = gender
            
            
    }
    
    
    class func newPerson(context: NSManagedObjectContext, firstname: String, surname: String, age: Int, gender: String) -> Person {
        
        return Person(context: context, firstname: firstname, surname: surname, age: age, gender: gender)
    }

}