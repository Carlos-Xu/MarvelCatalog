//
//  SimpleError.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct SimpleError: LocalizedError {
    var description: String? = nil
}

extension SimpleError {
    var errorDescription: String? {
        description
    }
}
