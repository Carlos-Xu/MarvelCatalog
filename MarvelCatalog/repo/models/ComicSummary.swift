//
//  ComicSummary.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct ComicSummary: Decodable {
    var resourceURI: String? // The path to the individual comic resource.,
    var name: String? // The canonical name of the comic.
}
