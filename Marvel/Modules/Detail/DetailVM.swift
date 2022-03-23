//
//  DetailVM.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import Foundation

class DetailVM: VM {
    
    var observer: ((Error?) -> Void)?
    var data: [Decodable]
    var netServices: Service?
    
    var characterID: Int?
    
    var character: Hero? { return self.data.first as? Hero }
    var comics: [ElementData?]?
    var series: [ElementData?]?
    var stories: [ElementData?]?
    var events: [ElementData?]?
    
    init(characterID: Int, services: Service) {
        self.data = []
        self.characterID = characterID
        self.netServices = services
    }
    
    func getData() {
        self.data.removeAll()
        
        if let id = self.characterID {
            self.netServices?.getCharacterData(for: id) { [ weak self ] result in
                guard let wSelf = self else { return }
                
                switch result {
                case .success(let hero):
                    wSelf.data = hero.data.data
                    wSelf.fetchData()
                    
                case .failure(let error):
                    wSelf.observer?(error)
                }
            }
        } else {
            self.observer?(ErrorModel(ErrorKey.notFound.rawValue))
        }
    }
    
    func fetchData() {
        self.comics?.removeAll()
        self.series?.removeAll()
        self.stories?.removeAll()
        self.events?.removeAll()
        
        let dispatchGroup = DispatchGroup()
        var errors: [ErrorModel?] = []
        
        if let data = self.character?.comics.items {
            data.forEach { comic in
                dispatchGroup.enter()
                
                self.getData(for: comic.resourceURI) { [ weak self ] (data, error) in
                    guard let wSelf = self else { dispatchGroup.leave(); return }
                    
                    comic.elementData = data
                    wSelf.comics?.append(data)
                    errors.append(error)
                    dispatchGroup.leave()
                }
            }
        }
        
        if let data = self.character?.series.items {
            data.forEach { serie in
                dispatchGroup.enter()
                
                self.getData(for: serie.resourceURI) { [ weak self ] (data, error) in
                    guard let wSelf = self else { dispatchGroup.leave(); return }
                    
                    serie.elementData = data
                    wSelf.series?.append(data)
                    errors.append(error)
                    dispatchGroup.leave()
                }
            }
        }
        
        if let data = self.character?.stories.items {
            data.forEach { story in
                dispatchGroup.enter()
                
                self.getData(for: story.resourceURI) { [ weak self ] (data, error) in
                    guard let wSelf = self else { dispatchGroup.leave(); return }
                    
                    story.elementData = data
                    wSelf.stories?.append(data)
                    errors.append(error)
                    dispatchGroup.leave()
                }
            }
        }
        
        if let data = self.character?.events.items {
            data.forEach { event in
                dispatchGroup.enter()
                
                self.getData(for: event.resourceURI) { [ weak self ] (data, error) in
                    guard let wSelf = self else { dispatchGroup.leave(); return }
                    
                    event.elementData = data
                    wSelf.events?.append(data)
                    errors.append(error)
                    dispatchGroup.leave()
                }
            }
        }
   
        dispatchGroup.notify(queue: .main) { self.observer?(errors.compactMap { return $0 }.first) }
    }
    
    func getData(for url: String, completion: @escaping ElementResponse) {
        self.netServices?.getElementData(for: url) { result in
            switch result {
            case .success(let resultData):
                if let firstData = resultData.data.data.first {
                    completion(firstData, nil)
                } else {
                    completion(nil, ErrorModel("Could not get element data"))
                }
                
            case .failure(let errorModel):
                completion(nil, errorModel)
            }
        }
    }
    
    func share() { if let hero = self.character { SocialManager.shared.share(hero: hero) } }
}
