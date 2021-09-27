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
    @IBOutlet weak var charactersLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var attributionLabel: UILabel!
    
    // Other properties
    var charactersTableAdapter: CharactersTableAdapter!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.startInitialTasks()
        
        // set up table adapter
        charactersTableAdapter = CharactersTableAdapter(onListEndIsNear: { [weak self] reachedRow in
            self?.vm.onCharactersListEndNearlyReached(reachedRow: reachedRow)
        }, onItemSelected: { [weak self] itemId in
            let vc: CharacterDetailPageVC?
            do {
                vc = try CharacterDetailPageRouter.makeVC(characterId: itemId)
            } catch {
                debugPrint(error.localizedDescription)
                vc = nil
            }
            
            if let vc = vc {
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                let alert = UIAlertController(title: LocTexts.Common.error, message: LocTexts.Common.unknown_error_explanation, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: LocTexts.Common.accept, style: .default, handler: { (_) in
                     }))
                self?.present(alert, animated: true, completion: nil)
            }

        })
        
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
    
    /// Updates UI according to provided ui description
    /// - Parameter ui: An object describing the UI's current desired state.
    func updateUI(_ ui: CharactersListPageUI) {
        let listUpdated = charactersTableAdapter.updateListIfChanged(ui.characters)
        if listUpdated {
            charactersTableView.reloadData()
        }
        
        if charactersLoadingIndicator.isAnimating != ui.listIsLoading {
            if ui.listIsLoading {
                charactersLoadingIndicator.startAnimating()
            } else {
                charactersLoadingIndicator.stopAnimating()
            }
        }
        
        attributionLabel.text = ui.attributionText
    }

}

