//
//  RequestModel.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class RequestModel: NSObject {
    
    private var md5 = MD5(secrets: EnvironmentVarRetriever())
    var endpoint: String { return "" }
    var path: String { return "" }
    var parameters: [String: Any?] { return self.md5.authenticate(with: TimeInterval.current) ?? [:] }
    var offset: Int { return 0 }
    var headers: [String: String] { return [:] }
    var method: RequestHTTPMethod { return body.isEmpty ? .get : .post }
    var body: [String: Any?] { return [:] }
    var isLoggingEnabled: (Bool, Bool) { return (true, true) }
    var data: Decodable? { return nil }
    
    func urlRequest() -> URLRequest {
        var endpoint: String = self.endpoint.appending(self.path)
        var paramString = "?"
        
        var newParams: [String: Any?] = self.parameters
        newParams["offset"] = "\(self.offset)"
        
        for parameter in newParams {
            if let value = parameter.value as? String {
                paramString.append("\(parameter.key)=\(value)&")
            }
        }
        
        if paramString == "?" {
            paramString = ""
        } else if paramString.last == "&" {
            paramString.removeLast()
        }
        
        endpoint.append(contentsOf: paramString)
        
        var request: URLRequest = URLRequest(url: URL(string: endpoint)!)
        
        request.httpMethod = self.method.rawValue
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if self.method == RequestHTTPMethod.post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let error {
                LogManager.e("Request body parse error: \(error.localizedDescription)")
            }
        }
        
        return request
    }
}
