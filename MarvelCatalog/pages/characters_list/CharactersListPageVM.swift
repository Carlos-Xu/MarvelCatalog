//
//  CharactersListPageVM.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation
import RxSwift

class CharactersListPageVM {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    private let _ui = BehaviorSubject<CharactersListPageUI>(value: CharactersListPageUI())
    var ui: Observable<CharactersListPageUI> { _ui }
    
    // MARK: - Lifecycle
    
    init() {
    }
    
    
}
