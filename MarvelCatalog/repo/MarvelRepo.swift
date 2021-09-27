//
//  MarvelRepository.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 20/7/21.
//

import Foundation
import Alamofire
import RxSwift

/// Provides access to Marvel's API's.
protocol MarvelRepo {
    
    /// Lists all characters.
    /// - Parameters:
    ///   - offset: Starting index
    ///   - limit: Max returned item count.
    func listCharactersRequest(offset: Int, limit: Int) -> RxDecodableRequest<CharacterDataWrapper>
    
    /// Gets the specified character's data.
    /// - Parameter characterId: Target character's ID.
    func getCharacterRequest(_ characterId: Int) -> RxDecodableRequest<CharacterDataWrapper>
    
}
