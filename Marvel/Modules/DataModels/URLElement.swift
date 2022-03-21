//
//  URLElement.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

class URLElement: Codable {
 
    let type: URLType
    let url: String

    init(type: URLType, url: String) {
        self.type = type
        self.url = url
    }
}
