//
//  Integers.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 20/7/21.
//

import Foundation

extension Int64 {
    
    /// Returns the hexadecimal representation of self
    /// - Returns: Hex string
    func toHexString() -> String {
        return String(self, radix: 16, uppercase: true)
    }
    
    /// Returns the string representation of self in the most compact way possible, using non numeric characters to encode more data in less characters.
    /// - Returns: Compressed representation of self.
    func toCompressedString() -> String {
        return String(self, radix: 36, uppercase: true)
    }
}

extension Int {
    
    /// Returns the hexadecimal representation of self
    /// - Returns: Hex string
    func toHexString() -> String {
        return String(self, radix: 16, uppercase: true)
    }
    
    /// Returns the string representation of self in the most compact way possible, using non numeric characters to encode more data in less characters.
    /// - Returns: Compressed representation of self.
    func toCompressedString() -> String {
        return String(self, radix: 36, uppercase: true)
    }
    
}
