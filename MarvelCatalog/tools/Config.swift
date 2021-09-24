//
//  Config.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 20/7/21.
//

import Foundation

/**
 Convenience class to access Configurations.
 */
enum Config {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    enum Key: String {
        case marvelPrivateApiKey = "MARVEL_PRIVATE_API_KEY"
        case marvelPublicApiKey = "MARVEL_PUBLIC_API_KEY"
        case marvelApiBaseUrl = "MARVEL_API_BASE_URL"
    }
    
    
    static func value(for key: Key) throws -> String {
        let keyString = key.rawValue
        
        let environment = ProcessInfo.processInfo.environment
        if let environmentValueString = environment[keyString] {
            return environmentValueString
        } else if let object = Bundle.main.object(forInfoDictionaryKey:keyString) {
            if let stringVal = object as? String {
                return stringVal
            } else {
                throw Error.invalidValue
            }
        } else {
            throw Error.invalidValue
        }
    }
}
