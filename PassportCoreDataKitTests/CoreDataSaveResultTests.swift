//
//  CoreDataSaveResultTests.swift
//  HLCoreDataHelpers
//
//  Created by Nicholas Wilding on 20/07/2016.
//  Copyright © 2016 Nicholas Wilding. All rights reserved.
//

import XCTest
@testable import HLCoreDataHelpers

class CoreDataSaveResultTests: XCTestCase {
    
    func testThat_SaveResult_ShowsError() {
        let success = CoreDataSaveResult.success
        XCTAssertNil(success.error())
        
        let failure = CoreDataSaveResult.failure(NSError(domain: "error", code: 0, userInfo: nil))
        XCTAssertNotNil(failure.error())
    }
    
    func testThat_SaveReult_HasDescription() {
        print("\(#function)")
        let success = CoreDataSaveResult.success
        XCTAssertNotNil(success.description)
        print(success.description)
        
        let failure = CoreDataSaveResult.failure(NSError(domain: "error", code: 0, userInfo: nil))
        XCTAssertNotNil(failure.description)
        print(failure.description)
    }
    
}
