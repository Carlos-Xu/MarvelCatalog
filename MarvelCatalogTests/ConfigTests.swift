//
//  MarvelCatalogTests.swift
//  MarvelCatalogTests
//
//  Created by Carlos Xu on 20/7/21.
//

import XCTest
@testable import MarvelCatalog

class ConfigTests: XCTestCase {

    let keys: [Config.Key] = [
        .marvelPrivateApiKey,
        .marvelPublicApiKey
    ]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReadValues() throws {
        for key in keys {
            let value: String? = try? Config.value(for: key)
            XCTAssertNotNil(value)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
