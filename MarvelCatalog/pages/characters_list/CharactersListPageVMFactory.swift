//
//  CharactersListPageVMFactory.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 26/7/21.
//

import Foundation


class CharactersListPageVMFactory {
    
    private let repo: MarvelRepo
    private let schedulers: MySchedulers
    
    init(repo: MarvelRepo, schedulers: MySchedulers) {
        self.repo = repo
        self.schedulers = schedulers
    }
    
    func createVM() -> CharactersListPageVM {
        return CharactersListPageVM(repo: repo, schedulers: schedulers)
    }
    
}
