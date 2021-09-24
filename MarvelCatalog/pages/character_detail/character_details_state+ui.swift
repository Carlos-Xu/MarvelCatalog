//
//  character_details_state+ui.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation

struct CharacterDetailPageState: Equatable {
    var characterImageUrl: URL? = nil
    var name: String = ""
    var descriptionTitle: String = LocTexts.CharacterDetailPage.description_title
    var description: String? = nil
    var isLoading: Bool = false
    var staticErrorMessage: String?
    var attributionText: String = ""
}


struct CharacterDetailPageUI: Equatable {
    
    var characterImageUrl: URL?
    var name: String
    var descriptionTitle: String
    var description: String?
    var isLoading: Bool
    var attributionText: String
    var staticErrorMessage: String?

    init(from state: CharacterDetailPageState) {
        self.characterImageUrl = state.characterImageUrl
        self.name = state.name
        self.descriptionTitle = state.descriptionTitle
        self.description = state.description
        self.isLoading = state.isLoading
        self.attributionText = state.attributionText
        self.staticErrorMessage = state.staticErrorMessage
    }
}
