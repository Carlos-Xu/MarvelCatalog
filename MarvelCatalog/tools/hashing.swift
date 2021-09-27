//
//  hashing.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 20/7/21.
//

import Foundation
import CryptoKit


/// Generates the md5 hash for the input string
/// - Parameter string: input string
/// - Returns: Md5 hash
func MD5(string: String) -> String {
    let computed = Insecure.MD5.hash(data: Data(string.utf8))
    return computed.map { String(format: "%02hhx", $0) }.joined()
}
