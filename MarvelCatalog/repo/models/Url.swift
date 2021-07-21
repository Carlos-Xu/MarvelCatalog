//
//  Url.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct Url: Decodable {
    var type: String? // A text identifier for the URL.,
    var url: String? // A full URL (including scheme, domain, and path).
}
