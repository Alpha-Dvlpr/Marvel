//
//  CharacterListVM.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

class CharacterListVM: VM {
    
    var observer: ((Error?) -> Void)?
    var data: [Decodable]
    var netServices: Service?
    var currentPage: Int = 0
    var pageSize: Int = 20
    var offset: Int { return self.currentPage * self.pageSize }
    
    init(service: Service) {
        self.data = []
        self.netServices = service
    }
    
    func getData() {
        self.netServices?.getCharacterList(offset: self.offset) { [ weak self ] result in
            guard let wSelf = self else { return }
            
            switch result {
            case .success(let data):
                wSelf.currentPage += 1
                wSelf.data.append(contentsOf: data.data.data)
                wSelf.observer?(nil)
                
            case .failure(let error):
                wSelf.observer?(error)
            }
        }
    }
    
    func getData(for url: String, completion: @escaping ElementResponse) { completion(nil, nil) }
}
