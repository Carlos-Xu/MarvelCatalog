//
//  LocTexts.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 24/9/21.
//

import Foundation


/// Contains all localized texts as static properties.
struct LocTexts {
    struct Common {
        static let accept = NSLocalizedString("accept", comment: "option accept")
        static let error = NSLocalizedString("error_title", comment: "error title")
        static let unknown_error_explanation = NSLocalizedString("unknown_error_explanation", comment: "Unknown error message explanation")
    }
    
    struct CharacterDetailPage {
        static let no_character_details_available = NSLocalizedString("no_character_details_available", comment: "No character details available message")
        static let description_title = NSLocalizedString("description_title", comment: "Description section title")
    }
}
