//
//  MarvelRepository.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 20/7/21.
//

import Foundation
import Alamofire
import RxSwift

class MarvelRepo {
    
    let baseUrl: String
    
    let privateKey: String
    let publicKey: String
    
    init() {
        baseUrl = try! Config.value(for: .marvelApiBaseUrl)
        privateKey = try! Config.value(for: .marvelPrivateApiKey)
        publicKey = try! Config.value(for: .marvelPublicApiKey)
    }
    
    func listCharacters() -> Single<CharacterDataWrapper> {
        let url = "\(baseUrl)/characters"
        
        return rxPerformRequestDecodable(of: CharacterDataWrapper.self, decoder: getDecoder()) { [weak self] in
            guard let selfRef = self else {
                throw SimpleError()
            }
            let parameters: Parameters = selfRef.generateAuthParameters()
            return AF.request(url, method: .get, parameters: parameters)
        }
    }
    
    func getCharacter(_ characterId: Int) -> Single<CharacterDataWrapper> {
        let url = "\(baseUrl)/characters/\(characterId)"
        
        return rxPerformRequestDecodable(of: CharacterDataWrapper.self, decoder: getDecoder()) { [weak self] in
            guard let selfRef = self else {
                throw SimpleError()
            }
            let parameters: Parameters = selfRef.generateAuthParameters()
            return AF.request(url, method: .get, parameters: parameters)
        }
    }
    
    // MARK: - Helpers
    
    private func generateAuthParameters() -> Parameters {
        let uniqueString = genUniqueString()
        
        let hashingStr = uniqueString + privateKey + publicKey
        let hash = MD5(string: hashingStr)
        
        return [
            "apikey": publicKey,
            "ts": uniqueString,
            "hash": hash
        ]
    }
    
    func getDecoder() -> Alamofire.DataDecoder {
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601 // Marvel doesn't state the time format. But It looks like iso8601.
        
        return decoder
    }
    
    
}
