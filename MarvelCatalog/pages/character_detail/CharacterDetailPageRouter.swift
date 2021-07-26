//
//  CharacterDetailPageRouter.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


class CharacterDetailPageRouter {
    
    static func makeVC(characterId: Int) -> CharacterDetailPageVC {
        let di = AppDelegate.getSharedInstance().di
        let vc: CharacterDetailPageVC = CommonRouter.makeVC()
        
        let vmFactory = di.resolve(CharacterDetailPageVMFactory.self)!
        
        vc.schedulers = di.resolve(MySchedulers.self)!
        vc.vm = vmFactory.createVM(with: CharacterDetailPageVM.Config(targetCharacterId: characterId))
        
        return vc
    }

}
