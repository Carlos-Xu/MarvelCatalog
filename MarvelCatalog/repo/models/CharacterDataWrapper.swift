//
//  CharacterDataWrapper.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct CharacterDataWrapper: Decodable {
    var code: Int? // The HTTP status code of the returned result.,
    var status: String? // A string description of the call status.,
    var copyright: String? // The copyright notice for the returned result.,
    var attributionText: String? // The attribution notice for this result. Please display either this notice or the contents of the attributionHTML field on all screens which contain data from the Marvel Comics API.,
    var attributionHTML: String? // An HTML representation of the attribution notice for this result. Please display either this notice or the contents of the attributionText field on all screens which contain data from the Marvel Comics API.,
    var data: CharacterDataContainer? // The results returned by the call.,
    var etag: String? // A digest value of the content returned by the call.
}
