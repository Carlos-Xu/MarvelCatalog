//
//  SeriesSummary.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct SeriesSummary: Decodable {
    var resourceURI: String? // The path to the individual series resource.,
    var name: String? // The canonical name of the series.
}
