//
//  CharacterDetailPageRouter.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


class CharacterDetailPageRouter {
    
    static func makeVC(characterId: Int) throws -> CharacterDetailPageVC {
        let di = AppDelegate.getSharedInstance().di
        let vc: CharacterDetailPageVC = CommonRouter.makeVC()
        
        guard let vmFactory = di.resolve(CharacterDetailPageVMFactory.self) else {
            throw SimpleError(description: "Failed to resolve CharacterDetailPageVMFactory")
        }
        
        guard let schedulers = di.resolve(MySchedulers.self) else {
            throw SimpleError(description: "Failed to resolve MySchedulers")
        }
        
        let vm: CharacterDetailPageVM = vmFactory.createVM(with: CharacterDetailPageVM.Config(targetCharacterId: characterId))
        
        vc.schedulers = schedulers
        vc.vm = vm
        
        return vc
    }

}
