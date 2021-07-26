//
//  Alamofire_Rx_Tests.swift
//  MarvelCatalogTests
//
//  Created by Carlos Xu on 26/7/21.
//

import XCTest
@testable import MarvelCatalog
import Mocker
import Alamofire
import RxSwift

class Alamofire_Rx_Tests: XCTestCase {
    
    struct TestStruct: Codable, Equatable {
        var dump: String
    }
    
    
    let sampleData = TestStruct(dump: "hi")
    let emptyEndpoint = URL(string: "https://api.example.com/empty")!
    let textEndpoint = URL(string: "https://api.example.com/text")!
    let jsonEndpoint = URL(string: "https://api.example.com/json")!
    var sessionManager: Session!
    var sampleStringData: Data!
    var sampleString: String!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        sessionManager = Session(configuration: configuration)
        
        sampleStringData = try! Data(contentsOf: MockedData.sampleJSON)
        sampleString = String(decoding: sampleStringData, as: UTF8.self)
        
        let mock = Mock(url: textEndpoint, dataType: .json, statusCode: 200, data: [.get: sampleStringData])
        mock.register()
        
        
        let sampleJson = try! JSONEncoder().encode(sampleData)
        Mock(url: jsonEndpoint, dataType: .json, statusCode: 200, data: [.get: sampleJson])
            .register()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRxPerformRequest() throws {
        let request = rxPerformRequest {
            self.sessionManager.request(self.textEndpoint)
        }
        .toBlocking()
        
        let singleResponse = try! request.single()
        
        XCTAssertEqual(singleResponse, sampleString)
    }
    
    func testRxPerformRequestError() throws {
        let requestEmpty = rxPerformRequest {
            self.sessionManager.request(self.emptyEndpoint)
        }
        .toBlocking()
        
        XCTAssertThrowsError(try requestEmpty.single())
    }
    
    func testRxPerformRequestDecodable() {
        let request = rxPerformRequestDecodable(of: TestStruct.self) {
            self.sessionManager.request(self.jsonEndpoint)
        }
        .toBlocking()
        
        let singleResponse = try! request.single()
        
        XCTAssertEqual(singleResponse, sampleData)
    }
    
    func testRxPerformRequestDecodable_Error() {
        let requestEmpty = rxPerformRequestDecodable(of: TestStruct.self) {
            self.sessionManager.request(self.emptyEndpoint)
        }
        .toBlocking()
        
        XCTAssertThrowsError(try requestEmpty.single())
        
        let requestWrongFormat = rxPerformRequestDecodable(of: TestStruct.self) {
            self.sessionManager.request(self.textEndpoint)
        }
        .toBlocking()
        
        XCTAssertThrowsError(try requestWrongFormat.single())
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
