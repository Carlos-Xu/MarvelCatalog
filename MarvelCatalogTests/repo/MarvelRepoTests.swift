//
//  MarvelRepoTests.swift
//  MarvelRepoTests
//
//  Created by Carlos Xu on 20/7/21.
//

import XCTest
import RxBlocking
import Mocker
import Alamofire
import RxSwift

@testable import MarvelCatalog

class MarvelRepoTests: XCTestCase {

    var repo: MarvelRepo!
    var mockedRepo: MarvelRepo!

    override func setUpWithError() throws {
        let baseUrl: String = try! Config.value(for: .marvelApiBaseUrl)
        let privateKey: String = try! Config.value(for: .marvelPrivateApiKey)
        let publicKey: String = try! Config.value(for: .marvelPublicApiKey)

        repo = MarvelRepo(baseUrl: baseUrl, privateKey: privateKey, publicKey: publicKey)
        
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let mockedSession = Session(configuration: configuration)
        
        mockedRepo = MarvelRepo(baseUrl: baseUrl, privateKey: privateKey, publicKey: publicKey, session: mockedSession)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCharactersReal() throws {
        let call = repo.listCharactersRequest(offset: 0, limit: 20).performRequest().toBlocking()

        do {
            let response = try call.toArray()
            XCTAssertEqual(response.count, 1)
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testGetCharactersFormat() throws {
        let request = mockedRepo.listCharactersRequest(offset: 0, limit: 20)
        let afRequest = try! request.generageAFRequest()
        
        let charactersData = try! Data(contentsOf: MockedData.sample_list_characters_response)
        let mock = Mock(url: afRequest.request!.url!, ignoreQuery: true, dataType: .json, statusCode: 200, data: [.get: charactersData])
        mock.register()

        let response = try? request.performRequest().toBlocking().single()
        
        XCTAssertNotNil(response)
    }

    func testGetCharacter() throws {
        let characterId = 1011334 // 3-D Man
        let call = repo.getCharacterRequest(characterId).performRequest().toBlocking()

        do {
            let response = try call.toArray()
            XCTAssertEqual(response.count, 1)
        } catch {
            XCTFail(String(describing: error))
        }
    }
    
    func testGetCharacterFormat() {
        let characterId = 1011334 // 3-D Man
        
        let request = mockedRepo.getCharacterRequest(characterId)
        let afRequest = try! request.generageAFRequest()
        
        let sampleData = try! Data(contentsOf: MockedData.sample_single_character_response)
        let mock = Mock(url: afRequest.request!.url!, ignoreQuery: true, dataType: .json, statusCode: 200, data: [.get: sampleData])
        mock.register()

        let response = try? request.performRequest().toBlocking().single()
        
        XCTAssertNotNil(response)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
