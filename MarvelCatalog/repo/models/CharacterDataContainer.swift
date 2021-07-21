//
//  CharacterDataContainer.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct CharacterDataContainer: Decodable {
    var offset: Int? // The requested offset (number of skipped results) of the call.,
    var limit: Int? // The requested result limit.,
    var total: Int? // The total number of resources available given the current filter set.,
    var count: Int? // The total number of results returned by this call.,
    var results: [Character]? // The list of characters returned by the call.
}
