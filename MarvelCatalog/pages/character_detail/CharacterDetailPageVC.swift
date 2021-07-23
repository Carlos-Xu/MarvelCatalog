//
//  CharacterDetailPageVC.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import UIKit

class CharacterDetailPageVC: SuperViewController {

    // MARK: - Properties
    
    // Injected
    var schedulers: MySchedulers!
    var vm: CharacterDetailPageVM!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vm.startInitialTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vm.ui
            .observe(on: schedulers.ui())
            .subscribe(onNext: { [weak self] in self?.updateUI($0) })
            .disposed(by: viewWillAppearDisposeBag)
    }
    
    // MARK: - UI Workers
    
    func updateUI(_ ui: CharacterDetailPageUI) {
        print(ui)
    }
    
}
