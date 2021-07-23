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
        
        let vm = di.resolve(CharacterDetailPageVM.self)!
        vm.targetCharacterId = characterId
        
        vc.schedulers = di.resolve(MySchedulers.self)!
        vc.vm = vm
        
        return vc
    }

}
