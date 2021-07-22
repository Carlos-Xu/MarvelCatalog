//
//  ViewController.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 20/7/21.
//

import UIKit

class CharactersListPageVC: SuperViewController {

    // MARK: - Properties
    
    // injected
    var schedulers: MySchedulers!
    var vm: CharactersListPageVM!
    
    // IBOutlets
    @IBOutlet weak var charactersTableView: UITableView!
    
    // Other properties
    let charactersTableAdapter = CharactersTableAdapter()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up Views
        charactersTableView.delegate = charactersTableAdapter
        charactersTableView.dataSource = charactersTableAdapter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vm.ui.observe(on: schedulers.ui())
            .subscribe { [weak self] in self?.updateUI($0) }
            .disposed(by: viewWillAppearDisposeBag)
    }
    
    // MARK: - UI Workers
    
    func updateUI(_ ui: CharactersListPageUI) {
        let listUpdated = charactersTableAdapter.updateListIfChanged(ui.characters)
        if listUpdated {
            charactersTableView.reloadData()
        }
    }

}

