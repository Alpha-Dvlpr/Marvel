//
//  Comics.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

class Comics: Codable {
    
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int

    init(available: Int, collectionURI: String, items: [ComicsItem], returned: Int) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
}

class ComicsItem: Codable {
    
    let resourceURI: String
    let name: String
    var elementData: ElementData? = nil

    init(resourceURI: String, name: String) {
        self.resourceURI = resourceURI
        self.name = name
    }
}
