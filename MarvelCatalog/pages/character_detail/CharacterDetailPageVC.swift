//
//  CharacterDetailPageVC.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import UIKit
import Kingfisher

class CharacterDetailPageVC: SuperViewController {

    // MARK: - Properties
    
    // Injected
    var schedulers: MySchedulers!
    var vm: CharacterDetailPageVM!
    
    // IBOutlets
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionDetails: UILabel!
    @IBOutlet weak var pageLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var attributionLabel: UILabel!
    @IBOutlet weak var errorMessageContainer: UIView!
    @IBOutlet weak var errorMessage: UILabel!
    
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        characterImage.kf.cancelDownloadTask()
    }
    
    // MARK: - UI Workers
    
    func updateUI(_ ui: CharacterDetailPageUI) {
        characterImage.kf.setImage(with: ui.characterImageUrl, placeholder: UIImage(named: "image_placeholder_marvel_portrait_big"), options: [.retryStrategy(DelayRetryStrategy(maxRetryCount: 3))])
        
        characterName.text = ui.name
        
        descriptionTitle.text = ui.descriptionTitle
        
        if let description = ui.description, !description.isEmpty {
            descriptionDetails.text = description
        } else {
            descriptionDetails.text = LocTexts.CharacterDetailPage.no_character_details_available
        }
        
        if pageLoadingIndicator.isAnimating != ui.isLoading {
            if ui.isLoading {
                pageLoadingIndicator.startAnimating()
            } else {
                pageLoadingIndicator.stopAnimating()
            }
        }
        
        attributionLabel.text = ui.attributionText
        
        errorMessageContainer.isHidden = ui.staticErrorMessage == nil
        errorMessage.text = ui.staticErrorMessage
    }
    
}
