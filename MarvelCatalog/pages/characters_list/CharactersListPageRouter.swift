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
        let vmFactory = di.resolve(CharactersListPageVMFactory.self)!
        
        vc.schedulers = di.resolve(MySchedulers.self)!
        vc.vm = vmFactory.createVM()
        
        return vc
    }
    
}
