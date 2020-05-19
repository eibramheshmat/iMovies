//
//  iMoviesTests.swift
//  iMoviesTests
//
//  Created by Ibram on 5/18/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import XCTest
@testable import iMovies

class iMoviesTests: XCTestCase {

    //unit test for test that request successfully get data
    func testAPIRequestSuccessful() {
        let expectatin = XCTestExpectation(description: "Request movies list from TMDb")
        let url = URL(string: "\(Constants.baseUrl)?api_key=\(Constants.app_key)")
        let task = URLSession.shared.dataTask(with: url!){(_, response, _) in
            if let responseHTTP = response as? HTTPURLResponse{
                XCTAssertEqual(responseHTTP.statusCode, 200)
                expectatin.fulfill()
            }
        }
        task.resume()
        wait(for: [expectatin], timeout: 10.0)/// to wait while response back
    }
    
    //unit test for test validate date
    func testDateValidate() {
        let str = "2002-05-23"
        let str2 = "23-05-2002"
        XCTAssertTrue(str.validateDate(date: str))
        XCTAssertEqual(str2.validateDate(date: str2), false)
    }

}
