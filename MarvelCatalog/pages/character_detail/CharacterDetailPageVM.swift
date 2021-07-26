//
//  CharacterDetailPageVM.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation
import RxSwift


class CharacterDetailPageVM {
    
    // MARK: - Properties
    
    // config properties
    
    var targetCharacterId: Int!
    
    // other properties
    
    private let disposeBag = DisposeBag()
    
    private let stateSemaphore = DispatchSemaphore(value: 1)
    private var state = CharacterDetailPageState()
    
    private let _stateReceiver = BehaviorSubject<CharacterDetailPageState>(value: CharacterDetailPageState())
    var ui: Observable<CharacterDetailPageUI>

    private let characterLoadRequests = PublishSubject<Int>() // Int is the CharacterId
    
    // MARK: - Lifecycle
    
    init(repo: MarvelRepo, schedulers: MySchedulers) {
        // set up
        ui = _stateReceiver
            .observe(on: schedulers.serial(qos: .userInteractive))
            .map { CharacterDetailPageUI(from: $0) }
        
        
        characterLoadRequests
            .flatMapLatest { characterId in
                repo.getCharacter(characterId)
                    .do(onSubscribe: { [weak self] in
                        self?.updateState { old in
                            var old = old
                            old.isLoading = true
                            return old
                        }
                    })
                    .map { result -> LoadResult in
                        guard let character = result.data?.results?.first else {
                            return LoadResult.failed
                        }
                        return LoadResult.success(character: character)
                    }
                    .asInfallible(onErrorJustReturn: LoadResult.failed)
            }
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let character):
                    self?.updateState { state in
                        var state = state
                        state.name = character.name ?? ""
                        state.description = character.description
                        state.characterImageUrl = character.thumbnail?.buildFullURL(ofType: .landscape_xlarge)
                        state.isLoading = false
                        state.staticErrorMessage = nil
                        return state
                    }
                case .failed:
                    self?.updateState { _ in
                        var newState = CharacterDetailPageState()
                        newState.staticErrorMessage = "Failed to load"
                        return newState
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    func startInitialTasks() {
        characterLoadRequests.onNext(targetCharacterId)
    }
    
    // MARK: - State updates
    
    func updateState(_ updateFunc: (CharacterDetailPageState) -> CharacterDetailPageState) {
        stateSemaphore.wait()
        let oldState = self.state
        let newState = updateFunc(oldState)
        self.state = newState
        stateSemaphore.signal()

        if oldState != newState {
            _stateReceiver.onNext(newState)
        }
    }
    
    // MARK: - Events
    
    
}


private enum ListLoadEvent {
    case loadPage(page: Int)
}

private enum LoadResult {
    case success(character: Character)
    case failed
}
