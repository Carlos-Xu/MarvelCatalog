//
//  CharacterDetailPageVMFactory.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 26/7/21.
//

import Foundation


class CharacterDetailPageVMFactory {
    
    private let repo: MarvelRepo
    private let schedulers: MySchedulers
    
    init(repo: MarvelRepo, schedulers: MySchedulers) {
        self.repo = repo
        self.schedulers = schedulers
    }
    
    func createVM(with config: CharacterDetailPageVM.Config) -> CharacterDetailPageVM {
        return CharacterDetailPageVM(repo: repo, schedulers: schedulers, config: config)
    }
    
    
}
