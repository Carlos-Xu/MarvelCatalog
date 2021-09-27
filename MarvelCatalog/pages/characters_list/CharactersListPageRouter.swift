//
//  CharactersListPageRouter.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


class CharactersListPageRouter {
    
    /// Instantiates a CharactersListPageVC with all it's required dependencies.
    /// - Throws: An error if fails to instantiate VC.
    /// - Returns: Instantiated CharactersListPageVC
    static func makeVC() throws -> CharactersListPageVC {
        let di = AppDelegate.getSharedInstance().di
        let vc: CharactersListPageVC = CommonRouter.makeVC()
        
        
        guard let vmFactory = di.resolve(CharactersListPageVMFactory.self) else {
            throw SimpleError(description: "Failed to resolve CharactersListPageVMFactory")
        }

        guard let schedulers = di.resolve(MySchedulers.self) else {
            throw SimpleError(description: "Failed to resolve MySchedulers")
        }
        
        let vm: CharactersListPageVM = vmFactory.createVM()
        
        vc.schedulers = schedulers
        vc.vm = vm
        
        return vc
    }
    
}
