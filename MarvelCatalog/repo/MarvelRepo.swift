//
//  MarvelRepository.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 20/7/21.
//

import Foundation
import Alamofire
import RxSwift

/**
 Provides access to Marvel's API's.
 */
protocol MarvelRepo {
    
    func listCharactersRequest(offset: Int, limit: Int) -> RxDecodableRequest<CharacterDataWrapper>
    
    func getCharacterRequest(_ characterId: Int) -> RxDecodableRequest<CharacterDataWrapper>
    
}
