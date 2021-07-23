//
//  CharactersListPageUI.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation

struct CharactersListPageState: Equatable {
    var characterPages: [Int: [CharactersListPageUI.CharacterItem]] = [:]
    var ongoingListLoadingTasks: Int = 0
}


struct CharactersListPageUI {
    
    var characters: [CharacterItem]
    var listIsLoading: Bool
    
    init(from state: CharactersListPageState) {
        let entries = state.characterPages.map{ $0 }
        self.characters = entries
            .sorted { $0.key < $1.key }
            .flatMap { $1 }
        
        self.listIsLoading = state.ongoingListLoadingTasks > 0
    }
    
    struct CharacterItem: Equatable {
        var id: Int
        var name: String
        var thumbnailUrl: URL?
        
        init?(from character: Character, thumbnailType: MarvelImageVariant) {
            guard let id = character.id else {
                return nil
            }
            
            guard let name = character.name else {
                return nil
            }
            
            self.id = id
            self.name = name
            self.thumbnailUrl = character.thumbnail?.buildFullURL(ofType: thumbnailType)
        }
    }
    
}
