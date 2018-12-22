//
//  WebHelperTest.swift
//  LogitechChallengeTests
//
//  Created by Anurag on 21/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import XCTest
@testable import LogitechChallenge

class WebHelperTest: XCTestCase {

    // This test needs internet access for passing as it fetches data through network
    class WebHelperTest: XCTestCase {
        
        var sut: WebHelper!
        
        override func setUp() {
            super.setUp()
            sut = WebHelper()
        }
        
        override func tearDown() {
            sut = nil
            super.tearDown()
        }
        
        func testFetchPhotos() {
            
            // Given a api service
            let sut = self.sut
            
            // When fetch data called
            let expect = XCTestExpectation(description: "callback")
            
            sut?.callApi(completion: { (movieArray) in
                expect.fulfill()
                XCTAssertNotNil(movieArray)
            })
            
            wait(for: [expect], timeout: 8.0)
        }
        
    }

}
