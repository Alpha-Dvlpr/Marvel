//
//  Hero.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

class Hero: Codable {
    
    let id: Int
    let name, resultDescription: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]
    var nonEmptyDescription: String { return self.resultDescription.isEmpty ? Strings.noDescription.rawValue: self.resultDescription }

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }

    init(
        id: Int,
        name: String,
        resultDescription: String,
        modified: String,
        thumbnail: Thumbnail,
        resourceURI: String,
        comics: Comics,
        series: Comics,
        stories: Stories,
        events: Comics,
        urls: [URLElement]
    ) {
        self.id = id
        self.name = name
        self.resultDescription = resultDescription
        self.modified = modified
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
        self.urls = urls
    }
}
