//
//  Image.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct Image: Decodable {
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
    var path: String? // The directory path of to the image.,
    var fileExtension: String? // The file extension for the image.
}

extension Image {
   
    /**
     Builds and returns the full URL of the specified type.
     */
    func buildFullURL(ofType variant: MarvelImageVariant) -> URL? {
        guard let path = path, let fileExtension = fileExtension else {
            return nil
        }
        
        let fullPath: String
        switch variant {
        case .portrait_small,
             .portrait_medium,
             .portrait_xlarge,
             .portrait_fantastic,
             .portrait_uncanny,
             .portrait_incredible,
             .standard_small,
             .square_medium,
             .square_large,
             .square_xlarge,
             .square_fantastic,
             .square_amazing,
             .landscape_small,
             .landscape_medium,
             .landscape_large,
             .landscape_xlarge,
             .landscape_amazing,
             .landscape_incredible,
             .detail:
            fullPath = "\(path)/\(variant.rawValue).\(fileExtension)"
        case .full_size:
            fullPath = "\(path).\(fileExtension)"
        }
        
        let fixed = fullPath.replacingOccurrences(of: "http://", with: "https://")
        return URL(string: fixed)
    }
}
