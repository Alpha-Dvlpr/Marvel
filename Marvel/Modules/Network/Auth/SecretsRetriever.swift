//
//  SecretsRetriever.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

protocol SecretsRetriever {
    var publicKey: String? { get }
    var privateKey: String? { get }
}

class EnvironmentVarRetriever: SecretsRetriever {
    
    var publicKey: String? { return "3753199d1c5b684e35534010d6a53f8f" }
    var privateKey: String? { return "669bebc4f857aa32951f8220a9991d3538ff4829" }
}
