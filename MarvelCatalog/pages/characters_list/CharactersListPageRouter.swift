//
//  CharactersListPageRouter.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


class CharactersListPageRouter {
    
    static func makeVC() -> CharactersListPageVC {
        let di = AppDelegate.getSharedInstance().di
        let vc: CharactersListPageVC = CommonRouter.makeVC()
        
        vc.schedulers = di.resolve(MySchedulers.self)!
        vc.vm = di.resolve(CharactersListPageVM.self)!
        
        return vc
    }
    
}
