//
//  DetailVM.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import Foundation

class DetailVM: VM {
    
    var observer: ((Error?) -> Void)?
    var character: Hero?
    var characterID: Int?
//    private var globalDispatchGroup = DispatchGroup()
//    private var globalError: ErrorModel?
    var netServices: Service?
    
    var comics: [ElementData?]?
    var series: [ElementData?]?
    var stories: [ElementData?]?
    var events: [ElementData?]?
    
    init(characterID: Int, services: Service) {
        self.characterID = characterID
        self.netServices = services
    }
    
    func getCharacterData() {
        self.character = nil
        
        if let id = self.characterID {
            self.netServices?.getCharacterData(for: id) { [ weak self ] result in
                guard let wSelf = self else { return }
                
                switch result {
                case .success(let hero):
                    let character = hero.data.data.first
                    
                    wSelf.character = character
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
                
                self.fetchElement(for: comic.resourceURI) { [ weak self ] (data, error) in
                    comic.elementData = data
                    self?.comics?.append(data)
                    errors.append(error)
                    dispatchGroup.leave()
                }
            }
        }
        
        if let data = self.character?.series.items {
            data.forEach { serie in
                dispatchGroup.enter()
                
                self.fetchElement(for: serie.resourceURI) { [ weak self ] (data, error) in
                    serie.elementData = data
                    self?.series?.append(data)
                    errors.append(error)
                    dispatchGroup.leave()
                }
            }
        }
        
        if let data = self.character?.stories.items {
            data.forEach { story in
                dispatchGroup.enter()
                
                self.fetchElement(for: story.resourceURI) { [ weak self ] (data, error) in
                    story.elementData = data
                    self?.stories?.append(data)
                    errors.append(error)
                    dispatchGroup.leave()
                }
            }
        }
        
        if let data = self.character?.events.items {
            data.forEach { event in
                dispatchGroup.enter()
                
                self.fetchElement(for: event.resourceURI) { [ weak self ] (data, error) in
                    event.elementData = data
                    self?.events?.append(data)
                    errors.append(error)
                    dispatchGroup.leave()
                }
            }
        }
   
        dispatchGroup.notify(queue: .main) { self.observer?(errors.compactMap { return $0 }.first) }
    }

    func fetchElement(for url: String, completion: @escaping ((ElementData?, ErrorModel?) -> Void)) {
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
