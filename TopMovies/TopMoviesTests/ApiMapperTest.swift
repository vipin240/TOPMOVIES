//
//  Api_Mapper_Test.swift
//  TopMoviesTests
//
//  Created by Vipin Jain on 05/10/23.
//

import Foundation
import XCTest
@testable import TopMovies

class MyViewControllerTests: XCTestCase {
    
    func testUnwrapOptionalString() {
   let vc = RootViewController()
       
        XCTAssertEqual(((data?.count ?? 0)), 100)
    }
}
