//
//  MockedServiceManager.swift
//  MarvelTests
//
//  Created by Aarón Granado Amores on 21/3/22.
//

@testable import Marvel
import Foundation
import XCTest

class MockedServiceManager: Manager {
    
    static let shared: ServiceManager = ServiceManager()
    private var data: Data?
    
    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping ((Swift.Result<T, ErrorModel>) -> Void)) {
        if request.isLoggingEnabled.0 { LogManager.req(request) }
        
        func logError(with message: String) {
            let error = ErrorModel(message)
            LogManager.err(error)
            completion(.failure(error))
        }
        
        if let data = self.data {
            guard let model = try? JSONDecoder().decode(T.self, from: data)
            else { completion(.failure(ErrorModel("Error parsing JSON dictionary"))); return }
            
            completion(.success(model))
        } else {
            completion(.failure(ErrorModel("Could not find JSON dictionary")))
        }
    }
    
    func inflate(json: String) {
        let model: Data? = try? self.getJSON(bundle: Bundle(for: MarvelBaseTest.self), for: json)
       
        self.data = model
    }
    
    private func getJSON(bundle: Bundle, for jsonName: String) throws -> Data? {
        guard let path = bundle.path(forResource: jsonName, ofType: "json")
        else { print("Could not retrieve file \(jsonName).json"); return nil }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        
        return data
    }
}
