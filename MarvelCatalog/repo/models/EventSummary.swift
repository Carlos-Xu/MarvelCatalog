//
//  EventSummary.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct EventSummary: Decodable {
    var resourceURI: String? // The path to the individual event resource.,
    var name: String? // The name of the event.
}
