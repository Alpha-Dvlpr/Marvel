//
//  CharacterListVM.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

class CharacterListVM: VM {
    
    var observer: ((Error?) -> Void)?
    var characters: [Hero] = []
    var netServices: Service?
    
    init(service: Service) { self.netServices = service }
    
    func getCharacters() {
        self.characters.removeAll()
        
        self.netServices?.getCharacterList { [ weak self ] result in
            guard let wSelf = self else { return }
            
            switch result {
            case .success(let data):
                wSelf.characters = data.data.data
                wSelf.observer?(nil)
                
            case .failure(let error):
                wSelf.observer?(error)
            }
        }
    }
}
