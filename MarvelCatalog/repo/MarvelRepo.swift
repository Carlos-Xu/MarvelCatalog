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
        
    func listCharacters() -> Single<String> {
        let url = "\(baseUrl)/characters"
        
        return Single<String>.create { [weak self] observer in
            guard let selfRef = self else {
                return Disposables.create()
            }
            
            let parameters: Parameters = selfRef.generateAuthParameters()
            
            let request = AF.request(url, method: .get, parameters: parameters)
            
            request.responseString { response in
                guard let responseString = response.value else {
                    observer(.failure(SimpleError()))
                    return
                }
                observer(.success(responseString))
            }
            
            return Disposables.create{
                request.cancel()
            }
        }
    }
    
    func listCharacters2() -> Single<String> {
        let url = "\(baseUrl)/characters"
        
        return rxPerformRequest { [weak self] in
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

    
}
