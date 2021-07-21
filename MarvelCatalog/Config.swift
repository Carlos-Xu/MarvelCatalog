//
//  Config.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 20/7/21.
//

import Foundation


enum Config {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    enum Key: String {
        case marvelPrivateApiKey = "MARVEL_PRIVATE_API_KEY"
        case marvelPublicApiKey = "MARVEL_PUBLIC_API_KEY"
        case marvelApiBaseUrl = "MARVEL_API_BASE_URL"
    }
    
    
    static func value<T>(for key: Key) throws -> T where T: LosslessStringConvertible {
        let keyString = key.rawValue
        
        guard let object = Bundle.main.object(forInfoDictionaryKey:keyString) else {
            throw Error.missingKey
        }
        
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}
