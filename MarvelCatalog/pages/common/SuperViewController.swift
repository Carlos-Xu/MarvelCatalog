//
//  SuperViewController.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import UIKit
import RxSwift

/**
 Implements common behavior for ViewControllers. Features:
 - Provides managed lifecycle aware dispose bags for common lifecycle events
 */
class SuperViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewDidLoadDisposeBag = DisposeBag() // disposing when ViewController is deallocated
    var viewDidAppearDisposeBag = DisposeBag()
    var viewWillAppearDisposeBag = DisposeBag()

    // MARK: - Lifecycle
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewDidAppearDisposeBag = DisposeBag() // dipose all previously registered subscriptions
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewWillAppearDisposeBag = DisposeBag() // dipose all previously registered subscriptions
    }
    
}
