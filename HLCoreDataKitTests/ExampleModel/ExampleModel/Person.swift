//
//  Person.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import Foundation
import CoreData


(Person)
public class Person: ManagedObject {
    
    // OLD - public static let modelEntityName = "Person"

//    private convenience init(context: NSManagedObjectContext,
//        firstname: String,
//        surname: String,
//        age: Int,
//        gender: String) {
//            
//            let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)!
//            
//            self.init(entity: entity, insertIntoManagedObjectContext: context)
//            
//            self.firstname = firstname
//            self.surname = surname
//            self.age = age
//            self.gender = gender
//
//    }
//    
//    
//    public class func newPerson(context: NSManagedObjectContext, firstname: String, surname: String, age: Int, gender: String) -> Person {
//        
//        return Person(context: context, firstname: firstname, surname: surname, age: age, gender: gender)
//    }
//
//    
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        age = 99
    }
    
    public static func insertIntoContext(_ moc: NSManagedObjectContext,
                                         firstname: String,
                                         surname: String,
                                         age: Int,
                                         gender: String) -> Person {
        
        let person:Person = moc.insertObject()
        person.firstname = firstname
        person.surname = surname
        person.age = age
        person.gender = gender
        
        print("YYYY \(person)")
        return person
    }
}



extension Person: ManagedObjectType {
    public static var entityName: String {
        return "Person"
    }
    
    public static var defaultSortDesciptors: [SortDescriptor] {
        return [SortDescriptor(key: "gender", ascending: true)]
    }
}

extension Person {
    public enum Keys: String {
        case firstname
    }
}

