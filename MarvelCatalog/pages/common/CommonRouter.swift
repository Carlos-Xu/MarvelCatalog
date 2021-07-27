//
//  CommonRouter.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import UIKit

/**
 Convenicence class to help with Routing.
 */
class CommonRouter {
    
    /**
     Searches inside Main.storyboard for an UIViewController with the identifier set to T's name and instantiates an UIViewController associated with it.
     
     Raises an exception if ViewController is not found or it is not of the correct class.
     */
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
