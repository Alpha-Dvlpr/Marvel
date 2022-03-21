//
//  Service.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

typealias CharacterResponse = ((Swift.Result<MarvelData<Hero>, ErrorModel>) -> Void)
typealias ElementDataResponse = ((Swift.Result<MarvelData<ElementData>, ErrorModel>) -> Void)

protocol Service {
    
    var manager: Manager! { get set }
    
    func getCharacterList(completion: @escaping CharacterResponse)
    func getCharacterData(for character: Int, completion: @escaping CharacterResponse)
    func getElementData(for comicURL: String, completion: @escaping ElementDataResponse)
}
