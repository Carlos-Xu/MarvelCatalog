//
//  di_setup.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation
import Swinject



/// Creates a Swinject container with all necessary dependencies registered.
/// - Returns: Initialized container
func createInitializedDIContainer() -> Container {
    let container = Container()
    
    
    container.register(MySchedulers.self) { _ in
        MySchedulersImplementation()
    }
    .inObjectScope(.container)
    
    
    container.register(MarvelRepo.self) { _ in
        guard let baseUrl: String = try? Config.value(for: .marvelApiBaseUrl) else {
            fatalError("Base url for Marvel API not configured")
        }
        guard let privateKey: String = try? Config.value(for: .marvelPrivateApiKey) else {
            fatalError("Private key for Marvel API not configured")
        }
        guard let publicKey: String = try? Config.value(for: .marvelPublicApiKey) else {
            fatalError("Public key for Marvel API not configured")
        }
        
        return MarvelRepoImpl(baseUrl: baseUrl, privateKey: privateKey, publicKey: publicKey)
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
