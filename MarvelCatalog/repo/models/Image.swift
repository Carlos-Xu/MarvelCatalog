//
//  Image.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct Image: Decodable {
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
    var path: String? // The directory path of to the image.,
    var fileExtension: String? // The file extension for the image.
}
