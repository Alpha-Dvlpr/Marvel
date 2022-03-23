//
//  NetServices.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

class NetServices: Service {
    
    var manager: Manager!
    
    func getCharacterList(offset: Int, completion: @escaping CharacterResponse) {
        let model = CharacterListRequest(offset: offset)
        self.manager.sendRequest(request: model, completion: completion)
    }
    
    func getCharacterData(for character: Int, completion: @escaping CharacterResponse) {
        let model = CharacterDataRequest(id: character)
        self.manager.sendRequest(request: model, completion: completion)
    }
    
    func getElementData(for comicURL: String, completion: @escaping ElementDataResponse) {
        let model = ElementDataRequest(url: comicURL)
        self.manager.sendRequest(request: model, completion: completion)
    }
}
