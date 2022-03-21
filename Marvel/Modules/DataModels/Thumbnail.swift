//
//  Thumbnail.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

class Thumbnail: Codable {
    
    let path: String
    let thumbnailExtension: Extension
    var url: URL? { return URL(string: "\(self.path).\(self.thumbnailExtension.rawValue)") }

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }

    init(path: String, thumbnailExtension: Extension) {
        self.path = path
        self.thumbnailExtension = thumbnailExtension
    }
}
