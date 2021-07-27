//
//  MockedData.swift
//  MarvelCatalogTests
//
//  Created by Carlos Xu on 26/7/21.
//

import Foundation


public final class MockedData {
    
    
    public static let sample_list_characters_response: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "list_characters_example", ofType: "json")!)

    public static let sample_single_character_response: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "single_character_example", ofType: "json")!)

    public static let sample_md5s: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "sample_md5s", ofType: "json")!)
    
}
