//
//  Stories.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
}


class Stories: Codable {
    
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int

    init(available: Int, collectionURI: String, items: [StoriesItem], returned: Int) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
}

class StoriesItem: Codable {
    
    let resourceURI: String
    let name: String
    let type: ItemType
    var elementData: ElementData? = nil

    init(resourceURI: String, name: String, type: ItemType) {
        self.resourceURI = resourceURI
        self.name = name
        self.type = type
    }
}
