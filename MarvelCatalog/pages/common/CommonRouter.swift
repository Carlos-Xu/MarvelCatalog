//
//  CommonRouter.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import UIKit


class CommonRouter {
    
    static func makeVC<T: UIViewController>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
     
        let identifier = String(describing: T.self)
        let anyVC = storyboard.instantiateViewController(identifier: identifier)
        guard let page = anyVC as? T else {
            fatalError("wrong type")
        }
        
        return page
    }
    
}
