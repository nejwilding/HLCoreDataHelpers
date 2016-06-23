//
//  FetchedResultsController.swift
//  HLCoreDataKit
//
//  Created by Nicholas Wilding on 24/01/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//


import Foundation
import CoreData


public class FetchedResultsController: NSFetchedResultsController<AnyObject> {
    
    /// Creates new Fetched Results Controller with Request in a context
    ///
    /// :param: request             Fetch Request containing search criteria
    /// :param: inContext           Managed Object Context to perform search within
    /// :param: bySection           Section to group results in
    ///                             defaults to nill
    /// :param: withCache           Cache to cache results
    //                              defaults to nill
    public init(request: NSFetchRequest<AnyObject>, inContext context: NSManagedObjectContext,
        bySection section: String? = nil, withCache cache: String? = nil) {
            
            super.init(fetchRequest:request,
                managedObjectContext: context,
                sectionNameKeyPath: section,
                cacheName: cache)
            
            do {
                try self.performFetch()
            } catch {
                assertionFailure("Failed to fetch: \(error)")
            }

    }
    
    
//    /// Fetch Data for Results Controller
//    ///
//    func fetchData() {
//        do {
//            try self.performFetch()
//        } catch {
//            assertionFailure("Failed to fetch: \(error)")
//        }
//    }
    
    
    /// Number of sections in Results Controller
    ///
    /// :return:    returns Int count of number of sections
    ///             returns 0 if empty
    public func numberOfSections() -> Int {
        return self.sections?.count ?? 0
    }
    
    
    /// Number of rows in section
    ///
    /// :param: section     Integer value of section
    ///
    /// :return:            returns Int count of number of rows in section
    ///                     returns 0 if empty
    public func numberOfRowsInSection(_ section: Int) -> Int {
        let sectionInfo =  self.sections![section]
        return sectionInfo.numberOfObjects ?? 0
    }
    
    /// Number of objects in reesults controller
    ///
    /// :return:    returns Int count of number of objects in results controller
    ///             returns 0 if empty
    public func numberOfObjects() -> Int {
        return self.fetchedObjects?.count ?? 0
    }
    
    /// Section Title
    ///
    /// :param: section     Int value of section
    ///
    /// :return: returns Optional String of section title
    public func sectionTitle(_ section: Int) -> String? {
        let sectionInfo = self.sections![section]
        return sectionInfo.name
    }
    
    /// Object at Index Path
    ///
    /// :param: indexPath     Index Path value of selected row
    ///
    /// :return: returns generic object
    public func objectAtIndexPath <T: NSManagedObject> (_ indexPath: IndexPath) -> T {
        return self.object(at: indexPath) as! T
    }
    
}
