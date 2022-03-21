//
//  Authenticator.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation
import CryptoKit

protocol Authenticator {
    func authenticate(with timestamp: TimeInterval) -> [String: String]?
}

class MD5: Authenticator {
    
    private let secrets: SecretsRetriever
    
    init(secrets: SecretsRetriever) { self.secrets = secrets }
    
    func authenticate(with timestamp: TimeInterval) -> [String : String]? {
        guard let values = self.authentication(from: timestamp) else { return nil }
        
        return [
            "hash": values.hash,
            "apikey": values.publicKey,
            "ts": self.format(timestamp)
        ]
    }
    
    private func authentication(from timestamp: TimeInterval) -> (hash: String, publicKey: String)? {
        guard let fullKey = self.retrieveFullKey(using: timestamp),
              let hash = self.md5Hash(fullKey),
              let publicKey = self.secrets.publicKey,
              !publicKey.isEmpty
        else { return nil }
        
        return (hash: hash, publicKey: publicKey)
    }
    
    private func retrieveFullKey(using timestamp: TimeInterval) -> String? {
        guard let publicKey = self.secrets.publicKey,
              let privateKey = self.secrets.privateKey
        else { return nil }
        
        return String(Int(timestamp)) + privateKey + publicKey
    }
    
    private func md5Hash(_ source: String) -> String? {
        guard let data = source.data(using: .utf8) else { return nil }
        
        return Insecure.MD5.hash(data: data).map { String(format: "%02hhx", $0) }.joined()
    }
    
    private func format(_ timestamp: TimeInterval) -> String { return String(Int(timestamp)) }
}
