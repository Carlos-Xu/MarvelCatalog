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
    var description: String? = nil
    var isLoading: Bool = false
    var staticErrorMessage: String?
}


struct CharacterDetailPageUI {
    
    var characterImageUrl: URL?
    var name: String
    var description: String?
    var isLoading: Bool
    
    init(from state: CharacterDetailPageState) {
        self.characterImageUrl = state.characterImageUrl
        self.name = state.name
        self.description = state.description
        self.isLoading = state.isLoading
    }
}
