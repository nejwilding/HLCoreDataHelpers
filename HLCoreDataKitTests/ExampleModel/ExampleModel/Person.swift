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
        
        let person = Person(context: moc)
        person.firstname = firstname
        person.surname = surname
        person.age = age
        person.gender = gender
        
        print("YYYY \(person)")
        return person
    }
}



extension Person: ManagedObjectType {
    
    public typealias FetchRequestResult = Person

    public static var defaultSortDesciptors: [SortDescriptor] {
        return [SortDescriptor(key: "gender", ascending: true)]
    }
}

extension Person {
    public enum Keys: String {
        case firstname
    }
}

