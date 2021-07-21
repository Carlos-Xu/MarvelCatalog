//
//  Character.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation


struct Character: Decodable {
    var id: Int? // The unique ID of the character resource.,
    var name: String? // The name of the character.,
    var description: String? // A short bio or description of the character.,
    var modified: Date? // FIXME: The date the resource was most recently modified.,
    var resourceURI: String? // The canonical URL identifier for this resource.,
    var urls: [Url]? // A set of public web site URLs for the resource.,
    var thumbnail: Image? // The representative image for this character.,
    var comics: ComicList? // A resource list containing comics which feature this character.,
    var stories: StoryList? // A resource list of stories in which this character appears.,
    var events: EventList? // A resource list of events in which this character appears.,
    var series: SeriesList? // A resource list of series in which this character appears.
}
