//
//  StorySummary.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct StorySummary: Decodable {
    var resourceURI: String? // The path to the individual story resource.,
    var name: String? // The canonical name of the story.,
    var type: String? // The type of the story (interior or cover).
}
