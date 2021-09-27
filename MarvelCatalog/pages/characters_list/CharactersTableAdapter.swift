//
//  CharactersTableAdapter.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 22/7/21.
//

import UIKit
import Kingfisher


/// Simple implementation of a Delegate and Data source for characters lists UITableViews
class CharactersTableAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    private var characters: [CharactersListPageUI.CharacterItem] = []
    private let onListEndIsNear: (Int) -> Void // reachedRow -> void
    private let onItemSelected: (Int) -> Void // itemId -> void

    // MARK: - Lifecycle
    
    init(onListEndIsNear: @escaping (Int) -> Void, onItemSelected: @escaping (Int) -> Void) {
        self.onListEndIsNear = onListEndIsNear
        self.onItemSelected = onItemSelected
    }
    
    // MARK: - Events
    
    func updateListIfChanged(_ newList: [CharactersListPageUI.CharacterItem]) -> Bool {
        if characters == newList {
            return false
        } else {
            characters = newList
            return true
        }
    }
    
    // MARK: - Delegate and datasource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count // only 1 section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterListItemCell", for: indexPath) as! CharacterListItemCell
        
        let item = characters[indexPath.row]
        
        cell.itemTitle.text = item.name
        
        // not using Marvel's "image_not_available" image as placeholder, so we can distinguish easily whether the image failed to load or it wasn't provided by the API
        cell.itemImage.kf.setImage(with: item.thumbnailUrl, placeholder: UIImage(named: "thumbnail_placeholder_square_48pt_x1"))
        
        if indexPath.row > (characters.endIndex - CharactersListPageConfig.itemsRemainingWhenFetchingNextPage) {
            self.onListEndIsNear(indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectedItem = characters[indexPath.row]
        onItemSelected(sectedItem.id)
    }

    
}
