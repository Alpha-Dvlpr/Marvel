//
//  CharacterListRequest.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

class CharacterListRequest: RequestModel {

    var off: Int
    
    init(offset: Int) { self.off = offset }
    
    override var endpoint: String { return Endpoints.baseURL.rawValue }
    override var path: String { return Endpoints.characters.rawValue }
    override var offset: Int { return self.off }
}
