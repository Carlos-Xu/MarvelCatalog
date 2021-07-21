//
//  ComicList.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct ComicList: Decodable {
    var available: Int? // The number of total available issues in this list. Will always be greater than or equal to the "returned" value.,
    var returned: Int? // The number of issues returned in this collection (up to 20).,
    var collectionURI: String? // The path to the full list of issues in this collection.,
    var items: [ComicSummary]? // The list of returned issues in this collection.
}
