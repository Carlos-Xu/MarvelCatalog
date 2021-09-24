//
//  RepositoryError.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


enum RepositoryError: LocalizedError {
    case empty_response
    case general_error(wrappedError: Error, responseString: String?)
}

extension RepositoryError {
    var errorDescription: String? {
        switch self {
        case .empty_response:
            return "RepositoryError.empty_response"
        case .general_error(let wrappedError, let responseString):
            return "RepositoryError.general_error(Wrapped error: \(wrappedError.localizedDescription); ResponseString: \(responseString ?? "")"
        }
    }
}
