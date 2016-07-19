//
//  FetchedResultsController.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 24/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//


import Foundation
import CoreData

/// DataSoureProtocol
protocol DataSoureProtocol {

	/// ResultType from NSFetchRequest
    associatedtype ResultType: NSFetchRequestResult
    
    /// Number of sections in datasource
    var numberOfSections: Int { get }
    
    /// Number of rows per section in datasource
    func numberOfRowsInSection(section: Int) -> Int
    
    /// Array of objects in datasource
    //var objects: [ResultType]? { get }
    
	/// Object in datasource at indexPath
    func object(at indexPath: IndexPath) -> ResultType
    
    /// Title of section in datasource
    func sectionTitle(_ section: Int) -> String?
}


//extension NSFetchedResultsController {
    
    
//    
//    convenience init(fetchRequest: NSFetchRequest<ResultType>, managedObjectContext: NSManagedObjectContext) {
//        
//        self.init(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
//    }
//    
//    
//    var numberOfSections: Int {
//        return sections?.count ?? 0
//    }
//    
//    func numberOfRowsInSection(section: Int) -> Int {
//        //let sectionInfo = sections?[section]
//        return 12 //sectionInfo?.numberOfObjects ?? 0
//    }
//
//    
//    /// Section Title
//    ///
//    /// :param: section     Int value of section
//    ///
//    /// :return: returns Optional String of section title
//    public func sectionTitle(_ section: Int) -> String? {
//        let sectionInfo = sections![section]
//        return sectionInfo.name
//    }
//}

class FetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>{
    
    override init(fetchRequest: NSFetchRequest<ResultType>, managedObjectContext context: NSManagedObjectContext, sectionNameKeyPath: String? = nil, cacheName name: String? = nil) {
        
        super.init(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: sectionNameKeyPath, cacheName: name)
    }
}

extension FetchedResultsController: DataSoureProtocol {
    
    typealias ResultType = NSFetchRequestResult

    /// Number of sections in Results Controller
    ///
    /// - Returns: Int count of number of sections - 0 if empty
    ///
    var numberOfSections: Int {
        return sections?.count ?? 0
    }
    
    /// Number of rows in section
    ///
    /// - Parameter section: Integer value of section
    ///
    /// - Returns: Int count of number of rows in section - 0 if empty
    ///
    func numberOfRowsInSection(section: Int) -> Int {
        let sectionInfo = sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }

    /// Fetched objects in Results Controller
    ///
    /// - Returns: Array collection of ResultTypes
    ///
    var objects: [ResultType]? {
        return fetchedObjects
    }
  
    /// Section Title
    ///
    /// - Parameter section: Section Integer
    ///
    /// - Returns: Optional String of section title
    func sectionTitle(_ section: Int) -> String? {
        let sectionInfo = sections![section]
        return sectionInfo.name
    }
}

