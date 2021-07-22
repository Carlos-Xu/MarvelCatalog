//
//  MarvelImageVariant.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 22/7/21.
//

import Foundation


enum MarvelImageVariant: String {
    
    // portrait
    
    case portrait_small // 50x75px
    case portrait_medium // 100x150px
    case portrait_xlarge // 150x225px
    case portrait_fantastic // 168x252px
    case portrait_uncanny // 300x450px
    case portrait_incredible // 216x324px
    

    // Standard (square) aspect ratio
    
    case standard_small // 65x45px: not really square
    case square_medium = "standard_medium" // 100x100px
    case square_large = "standard_large" // 140x140px
    case square_xlarge = "standard_xlarge" // 200x200px
    case square_fantastic = "standard_fantastic" // 250x250px
    case square_amazing = "standard_amazing" // 180x180px
    
    
    // Landscape aspect ratio
    
    case landscape_small // 120x90px
    case landscape_medium // 175x130px
    case landscape_large // 190x140px
    case landscape_xlarge // 270x200px
    case landscape_amazing // 250x156px
    case landscape_incredible // 464x261px
    
    
    // Full size images
    
    case detail // full image, constrained to 500px wide
    case full_size // variant descriptor
}
