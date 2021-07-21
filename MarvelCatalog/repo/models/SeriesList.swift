//
//  SeriesList.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct SeriesList: Decodable {
    var available: Int? // The number of total available series in this list. Will always be greater than or equal to the "returned" value.,
    var returned: Int? // The number of series returned in this collection (up to 20).,
    var collectionURI: String? // The path to the full list of series in this collection.,
    var items: [SeriesSummary]? // The list of returned series in this collection.
}
