//
//  ErrorModel.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

class ErrorModel: Error {
    
    var messageKey: String
    var message: String { return self.messageKey }
    
    init(_ messageKey: String) { self.messageKey = messageKey }
    
    class func generalError() -> ErrorModel { return ErrorModel(ErrorKey.general.rawValue) }
}
