//
//  CharacterDetailPageVM.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation
import RxSwift


class CharacterDetailPageVM {
    
    struct Config {
        var targetCharacterId: Int
    }
    
    // MARK: - Properties
    
    // config properties
    
    private let config: Config
    
    // other properties
    
    private let disposeBag = DisposeBag()
    
    private let stateSemaphore = DispatchSemaphore(value: 1)
    private var state = CharacterDetailPageState()
    
    private let _stateReceiver = BehaviorSubject<CharacterDetailPageState>(value: CharacterDetailPageState())
    var ui: Observable<CharacterDetailPageUI>

    private let characterLoadRequests = PublishSubject<Int>() // Int is the CharacterId
    
    // MARK: - Lifecycle
    
    init(repo: MarvelRepo, schedulers: MySchedulers, config: Config) {
        self.config = config
        
        // set up
        ui = _stateReceiver
            .observe(on: schedulers.serial(qos: .userInteractive))
            .map { CharacterDetailPageUI(from: $0) }
        
        
        characterLoadRequests
            .flatMapLatest { characterId in
                repo.getCharacterRequest(characterId)
                    .performRequest()
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
                        return LoadResult.success(data: SuccessData(character: character, attributionText: result.attributionText))
                    }
                    .asInfallible(onErrorJustReturn: LoadResult.failed)
            }
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let data):
                    self?.updateState { state in
                        var state = state
                        state.name = data.character.name ?? ""
                        state.description = data.character.description
                        state.characterImageUrl = data.character.thumbnail?.buildFullURL(ofType: .landscape_xlarge)
                        state.isLoading = false
                        state.staticErrorMessage = nil
                        state.attributionText = data.attributionText ?? state.attributionText
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
        characterLoadRequests.onNext(config.targetCharacterId)
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
    
}


private enum ListLoadEvent {
    case loadPage(page: Int)
}

private enum LoadResult {
    case success(data: SuccessData)
    case failed
}

struct SuccessData {
    let character: Character
    let attributionText: String?
}
