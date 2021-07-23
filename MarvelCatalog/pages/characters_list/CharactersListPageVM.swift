//
//  CharactersListPageVM.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation
import RxSwift

// config
private let listPageSize = 20

class CharactersListPageVM {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    private let stateSemaphore = DispatchSemaphore(value: 1)
    private var state = CharactersListPageState()
    
    private let _stateReceiver = BehaviorSubject<CharactersListPageState>(value: CharactersListPageState())
    var ui: Observable<CharactersListPageUI>
    
    private let _messages = PublishSubject<String>()
    var messages: Observable<String> { _messages }
    
    private let _listPageLoadRequests = PublishSubject<Int>() // load requested page. First page is page 0
    
    // MARK: - Lifecycle
    
    init(repo: MarvelRepo, schedulers: MySchedulers) {
        // set up
        ui = _stateReceiver
            .map { CharactersListPageUI(from: $0) }
        
        _listPageLoadRequests
            .distinctUntilChanged() // prevent loading same page twice
            .flatMap { pageToLoad -> Observable<(page: Int, response: CharacterDataWrapper)> in
                let offset = pageToLoad * listPageSize
                
                return repo.listCharacters(offset: offset, limit: listPageSize)
                    .asObservable()
                    .do(onSubscribe: { [weak self] in
                        self?.updateState { old in
                            var old = old
                            old.ongoingListLoadingTasks += 1
                            return old
                        }
                    })
                    .map { (page: pageToLoad, response: $0) }
                    .retry(when: { errors in
                        errors.delay(.seconds(1), scheduler: schedulers.concurrent(qos: .userInitiated))
                    })
            }
            .subscribe(on: schedulers.serial(qos: .userInitiated))
            .subscribe { [weak self] event in
                guard let loadingPage = event.element?.page, let response = event.element?.response else {
                    // request failed
                    self?.updateState { old in
                        var old = old
                        old.ongoingListLoadingTasks -= 1
                        return old
                    }
                    self?._messages.onNext("Failed to load characters list")
                    return
                }
                
                let characters: [Character] = response.data?.results ?? []
                let uiCharacters = characters.compactMap{ CharactersListPageUI.CharacterItem(from: $0, thumbnailType: .square_medium) }
                
                self?.updateState {
                    var old = $0
                    old.ongoingListLoadingTasks -= 1
                    old.characterPages[loadingPage] = uiCharacters
                    return old
                }
            }
            .disposed(by: disposeBag)
        
        // first loads
        _listPageLoadRequests.onNext(0)
    }
    
    // MARK: - Events
    
    func requestListReload() {
        //        _listPageLoadRequests.onNext(true)
    }
    
    func requestTryLoadingListsNextPage() {
        
    }
    
    // MARK: - Helpers
    
    func updateState(_ updateFunc: (CharactersListPageState) -> CharactersListPageState) {
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
