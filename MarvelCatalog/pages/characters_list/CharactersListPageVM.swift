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
    
    private let _messages = PublishSubject<String>()
    var messages: Observable<String> { _messages }
    
    private let _listLoadRequests = BehaviorSubject<Bool>(value: false) // load on true events
    
    // MARK: - Lifecycle
    
    init(repo: MarvelRepo, schedulers: MySchedulers) {
        // set up
        _listLoadRequests.flatMapLatest { shouldLoad -> Infallible<CharacterDataWrapper?> in
            if shouldLoad {
                return repo.listCharacters()
                    .map({ $0 as CharacterDataWrapper? })
                    .asObservable()
                    .do(onSubscribe: { [weak self] in
                        guard var ui = try? self?._ui.value() else {
                            return
                        }
                        ui.listIsLoading = true
                        self?._ui.onNext(ui)
                    })
                    .retry(3)
                    .asInfallible(onErrorJustReturn: nil)
            } else {
                return Infallible.empty()
            }
        }
        .subscribe(on: schedulers.serial(qos: .userInitiated))
        .subscribe { [weak self] event in
            guard let temp = event.element, let dataWrapper = temp else {
                // request failed
                self?.updateUI { $0.listIsLoading = false }
                self?._messages.onNext("Failed to load characters list")
                return
            }
            
            let characters: [Character] = dataWrapper.data?.results ?? []
            let uiCharacters = characters.compactMap{ CharactersListPageUI.CharacterItem(from: $0, thumbnailType: .square_medium) }
            
            self?.updateUI { ui in
                ui.listIsLoading = false
                ui.characters = uiCharacters
            }
        }
        .disposed(by: disposeBag)
        
        // first loads
        _listLoadRequests.onNext(true)
    }
    
    // MARK: - Events
    
    func requestListReload() {
        _listLoadRequests.onNext(true)
    }
    
    // MARK: - Helpers
    
    func updateUI(_ updateFunc: (inout CharactersListPageUI) -> Void) {
        guard var ui = try? _ui.value() else {
            return
        }
        updateFunc(&ui)
        _ui.onNext(ui)
    }
    
}
