//
//  ViewModelProtocol.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import Foundation

typealias ElementResponse = ((ElementData?, ErrorModel?) -> Void)

protocol VM: AnyObject {
    var observer: ((Error?) -> Void)? { get set }
    var netServices: Service? { get set }
    var data: [Decodable] { get set }
    
    func getData()
    func getData(for url: String, completion: @escaping ElementResponse)
}
