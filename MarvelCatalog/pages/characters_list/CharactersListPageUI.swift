//
//  CharactersListPageUI.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct CharactersListPageUI {
    
    var characters: [CharacterItem] = []
    var listIsLoading: Bool = false
    
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
