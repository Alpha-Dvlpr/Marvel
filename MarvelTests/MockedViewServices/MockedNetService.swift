//
//  MockedNetService.swift
//  MarvelTests
//
//  Created by Aarón Granado Amores on 21/3/22.
//

@testable import Marvel

class MockedNetService: Service {
    
    var manager: Manager!
    
    func getCharacterList(completion: @escaping CharacterResponse) {
        self.manager.sendRequest(request: RequestModel(), completion: completion)
    }
    
    func getCharacterData(for character: Int, completion: @escaping CharacterResponse) {
        self.manager.sendRequest(request: RequestModel(), completion: completion)
    }
    
    func getElementData(for comicURL: String, completion: @escaping ElementDataResponse) {
        self.manager.sendRequest(request: RequestModel(), completion: completion)
    }
}
