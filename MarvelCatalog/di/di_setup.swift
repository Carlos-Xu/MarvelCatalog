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

    
    container.register(CharactersListPageVMFactory.self) { r in
        CharactersListPageVMFactory(repo: r.resolve(MarvelRepo.self)!, schedulers: r.resolve(MySchedulers.self)!)
    }
    .inObjectScope(.transient)
    
    container.register(CharacterDetailPageVMFactory.self) { r in
        CharacterDetailPageVMFactory(repo: r.resolve(MarvelRepo.self)!, schedulers: r.resolve(MySchedulers.self)!)
    }
    .inObjectScope(.transient)

    
    return container
}


let appDelegate = UIApplication.shared.delegate as! AppDelegate
let aVariable = appDelegate.di

