//
//  MarvelRepoTests.swift
//  MarvelRepoTests
//
//  Created by Carlos Xu on 20/7/21.
//

import XCTest
import RxBlocking

@testable import MarvelCatalog

class MarvelRepoTests: XCTestCase {

    var repo: MarvelRepo!
    
    override func setUpWithError() throws {
        repo = MarvelRepo()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let call = repo.listCharacters2().toBlocking()
        
        do {
            let response = try call.toArray()
            XCTAssertEqual(response.count, 1)
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
