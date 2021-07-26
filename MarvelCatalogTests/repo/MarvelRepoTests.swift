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

    func testGetCharacters() throws {
        let call = repo.listCharacters(offset: 0, limit: 20).toBlocking()
        
        do {
            let response = try call.toArray()
            XCTAssertEqual(response.count, 1)
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testGetCharacter() throws {
        let characterId = 1011334 // 3-D Man
        let call = repo.getCharacter(characterId).toBlocking()
        
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
