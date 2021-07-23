//
//  di_setup.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation
import Swinject



func initializeDIContainer() -> Container {
    let container = Container()
    
    
    container.register(MySchedulers.self) { _ in
        MySchedulersImplementation()
    }
    .inObjectScope(.container)
    
    
    container.register(MarvelRepo.self) { _ in
        MarvelRepo()
    }
    .inObjectScope(.container)

    
    container.register(CharactersListPageVM.self) { r in
        CharactersListPageVM(repo: r.resolve(MarvelRepo.self)!, schedulers: r.resolve(MySchedulers.self)!)
    }
    .inObjectScope(.transient)
    
    container.register(CharacterDetailPageVM.self) { r in
        CharacterDetailPageVM(repo: r.resolve(MarvelRepo.self)!, schedulers: r.resolve(MySchedulers.self)!)
    }
    .inObjectScope(.transient)

    
    return container
}


let appDelegate = UIApplication.shared.delegate as! AppDelegate
let aVariable = appDelegate.di

