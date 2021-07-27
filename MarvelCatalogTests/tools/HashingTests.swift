//
//  HashingTests.swift
//  MarvelCatalogTests
//
//  Created by Carlos Xu on 27/7/21.
//

import XCTest
@testable import MarvelCatalog
import Mocker
import Alamofire
import RxSwift

class HashingTests: XCTestCase {
    
    struct MD5Sample: Decodable {
        var text: String
        var md5: String
    }
    
    var samples: [HashingTests.MD5Sample]!
    
    override func setUpWithError() throws {
        let sampleData = try! Data(contentsOf: MockedData.sample_md5s)
        samples = try! JSONDecoder().decode([MD5Sample].self, from: sampleData)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMD5Generation() {
        for sample in samples {
            let calculatedMd5 = MD5(string: sample.text)
            XCTAssertEqual(calculatedMd5.uppercased(), sample.md5.uppercased())
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
