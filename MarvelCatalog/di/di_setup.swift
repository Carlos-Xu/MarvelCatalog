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
        let baseUrl: String = try! Config.value(for: .marvelApiBaseUrl)
        let privateKey: String = try! Config.value(for: .marvelPrivateApiKey)
        let publicKey: String = try! Config.value(for: .marvelPublicApiKey)
        
        return MarvelRepo(baseUrl: baseUrl, privateKey: privateKey, publicKey: publicKey)
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
