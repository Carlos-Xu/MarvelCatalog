//
//  MarvelRepoImpl.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 27/7/21.
//

import Foundation
import Alamofire
import RxSwift

/**
 Provides access to Marvel's API's.
 */
class MarvelRepoImpl: MarvelRepo {
    
    private let baseUrl: String
    
    private let privateKey: String
    private let publicKey: String
    
    private let session: Session
    
    init(baseUrl: String, privateKey: String, publicKey: String, session: Session = AF) {
        self.baseUrl = baseUrl
        self.privateKey = privateKey
        self.publicKey = publicKey
        self.session = session
    }
    
    func listCharactersRequest(offset: Int, limit: Int) -> RxDecodableRequest<CharacterDataWrapper> {
        let url = "\(baseUrl)/characters"
        
        return RxDecodableRequest(decoder: getDecoder()) { [weak self] in
            guard let selfRef = self else {
                throw SimpleError()
            }
            var parameters: Parameters = selfRef.generateAuthParameters()
            parameters["offset"] = offset
            parameters["limit"] = limit
            return selfRef.session.request(url, method: .get, parameters: parameters)
        }
    }
    
    func getCharacterRequest(_ characterId: Int) -> RxDecodableRequest<CharacterDataWrapper> {
        let url = "\(baseUrl)/characters/\(characterId)"
        
        return RxDecodableRequest(decoder: getDecoder()) { [weak self] in
            guard let selfRef = self else {
                throw SimpleError()
            }
            let parameters: Parameters = selfRef.generateAuthParameters()
            return selfRef.session.request(url, method: .get, parameters: parameters)
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
    
    private func getDecoder() -> Alamofire.DataDecoder {
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601 // Marvel doesn't state the time format. But It looks like iso8601.
        
        return decoder
    }
    
    
}
