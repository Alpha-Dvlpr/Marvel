//
//  ElementData.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import Foundation

class ElementData: Codable {
    
    let thumbnail: Thumbnail?
    let title: String
    
    init(thumbnail: Thumbnail, title: String) {
        self.thumbnail = thumbnail
        self.title = title
    }
}
