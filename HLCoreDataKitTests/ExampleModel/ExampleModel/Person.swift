//
//  Person.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 30/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import Foundation
import CoreData
import HLCoreDataHelpers

@objc(Person)
public class Person: ManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        age = 99
    }
    
    public static func insertIntoContext(_ moc: NSManagedObjectContext,
                                         firstname: String,
                                         surname: String,
                                         age: Int,
                                         gender: String) -> Person {
        
        let person: Person = Person(context:moc)
        person.firstname = firstname
        person.surname = surname
        person.age = age
        person.gender = gender
        
        return person
    }
}



extension Person: ManagedObjectType {
    
    public static var defaultSortDescriptors: [SortDescriptor] {
        return [SortDescriptor(key: Person.Keys.gender.rawValue, ascending: true)]
    }
    
    public static var defaultPredicate: Predicate {
        let predicate = Predicate(format: "%K == [n]%ld", Person.Keys.age.rawValue, 10)
        return predicate
    }
}

extension Person {
    public enum Keys: String {
        case firstname
        case age
        case gender
    }
}

