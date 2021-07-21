//
//  hashing.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 20/7/21.
//

import Foundation
import CryptoKit


func MD5(string: String) -> String {
    let computed = Insecure.MD5.hash(data: string.data(using: .utf8)!)
    return computed.map { String(format: "%02hhx", $0) }.joined()
}
