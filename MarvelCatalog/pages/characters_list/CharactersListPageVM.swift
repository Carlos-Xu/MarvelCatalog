//
//  CharactersListPageVM.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation
import RxSwift

// config
private let listPageSize = 50

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
            .observe(on: schedulers.serial(qos: .userInteractive))
            .map { CharactersListPageUI(from: $0) }
        
        _listPageLoadRequests
            .distinctUntilChanged() // prevent loading same page twice
            .flatMap { [weak self] pageToLoad -> Observable<(page: Int, response: CharacterDataWrapper)> in
                guard let selfRef = self else {
                    return Observable.empty()
                }
                let offset = selfRef.offset(forPage: pageToLoad)
                
                self?.updateState { old in
                    var old = old
                    old.ongoingListLoadingTasks += 1
                    return old
                }

                return repo.listCharactersRequest(offset: offset, limit: listPageSize)
                    .performRequest()
                    .map { (page: pageToLoad, response: $0) }
                    .retry(when: { errors -> Observable<Error> in
                        return errors.delay(.seconds(1), scheduler: schedulers.concurrent(qos: .userInitiated))
                    }) // never fails
                    .asObservable()
            }
            .subscribe(on: schedulers.serial(qos: .userInitiated))
            .subscribe(onNext: { [weak self] event in
                let response = event.response
                let loadingPage = event.page
                
                let characters: [Character] = response.data?.results ?? []
                let uiCharacters = characters.compactMap{ CharactersListPageUI.CharacterItem(from: $0, thumbnailType: .square_medium) }
                
                self?.updateState {
                    var old = $0
                    old.ongoingListLoadingTasks -= 1
                    old.characterPages[loadingPage] = uiCharacters
                    old.totalCharactersCount = response.data?.total ?? old.totalCharactersCount
                    old.attributionText = response.attributionText ?? old.attributionText
                    return old
                }
            })
            .disposed(by: disposeBag)
    }
    
    func startInitialTasks() {
        _listPageLoadRequests.onNext(0)
    }
    
    // MARK: - State updates
    
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
    
    // MARK: - Events
    
    func onCharactersListEndNearlyReached(reachedRow: Int) {
        let currentState = self.state
        
        let currentPage = reachedRow / listPageSize // ignores all decimals.
        let nextPage = currentPage + 1
        let nextPageStart = offset(forPage: nextPage)
        
        if nextPageStart < currentState.totalCharactersCount {
            // load next page
            _listPageLoadRequests.onNext(nextPage)
        }
    }
    
    // MARK: - Convenience
    
    func offset(forPage page: Int) -> Int {
        let offset = page * listPageSize
        return offset
    }
    
}


private enum ListLoadEvent {
    case loadPage(page: Int)
}
