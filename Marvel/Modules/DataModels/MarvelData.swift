//
//  MarvelData.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

class MarvelData<T: Codable>: Codable {
   
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass<T>

    init(code: Int, status: String, copyright: String, attributionText: String, attributionHTML: String, etag: String, data: DataClass<T>) {
        self.code = code
        self.status = status
        self.copyright = copyright
        self.attributionText = attributionText
        self.attributionHTML = attributionHTML
        self.etag = etag
        self.data = data
    }
}

class DataClass<T: Codable>: Codable {
    
    let offset, limit, total, count: Int
    let data: [T]

    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case data = "results"
    }
    
    init(offset: Int, limit: Int, total: Int, count: Int, results: [T]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.data = results
    }
}
