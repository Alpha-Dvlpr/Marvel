//
//  ElementDataRequest.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import Foundation

class ElementDataRequest: RequestModel {
    
    private var url: String
    
    init(url: String) { self.url = url }
    
    override var endpoint: String { return self.url }
}
