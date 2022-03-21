//
//  CharacterDataRequest.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import Foundation

class CharacterDataRequest: RequestModel {

    private var id: Int
    
    init(id: Int) { self.id = id }
    
    override var endpoint: String { return Endpoints.baseURL.rawValue }
    override var path: String { return Endpoints.character(id: self.id).rawValue }
}
