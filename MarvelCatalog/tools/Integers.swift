//
//  Integers.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 20/7/21.
//

import Foundation

extension Int64 {
    
    func toHexString() -> String {
        return String(self, radix: 16, uppercase: true)
    }
    
    func toCompressedString() -> String {
        return String(self, radix: 36, uppercase: true)
    }
}

extension Int {
    
    func toHexString() -> String {
        return String(self, radix: 16, uppercase: true)
    }
    
    func toCompressedString() -> String {
        return String(self, radix: 36, uppercase: true)
    }
    
}
