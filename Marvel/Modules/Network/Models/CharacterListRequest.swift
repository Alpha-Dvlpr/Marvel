//
//  CharacterListRequest.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

class CharacterListRequest: RequestModel {

    override var endpoint: String { return Endpoints.baseURL.rawValue }
    override var path: String { return Endpoints.characters.rawValue }
}
