//
//  ConfigValue.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

//protocol ConfigValue {
//    var apiBaseURLString: String { get }
//    var scheme: AppScheme { get }
//}
//
//class MarvelConfigurationValues: ConfigValue {
//
//    lazy var scheme: AppScheme = scheme(fromConfigurationKey: "SCHEME")
//    lazy var apiBaseURLString: String = apiBaseURLString(fromConfigurationKey: "API_BASE_URL")
//    
//    private func scheme(fromConfigurationKey configurationKey: String) -> AppScheme {
//        guard let scheme = AppScheme(rawValue: value(forConfigurationKey: configurationKey)) else {
//            fatalError("Scheme value \(String(describing: value)) not in \(String(describing: AppScheme.self))")
//        }
//        
//        return scheme
//    }
//
//    private func apiBaseURLString(fromConfigurationKey configurationKey: String) -> String {
//        self.value(forConfigurationKey: configurationKey)
//    }
//
//    private func value(forConfigurationKey configurationKey: String) -> String {
//        guard let value = Bundle.main.object(forInfoDictionaryKey: configurationKey) as? String else {
//            fatalError("Could not retrieve configuration value for key \(configurationKey)")
//        }
//        
//        return value
//    }
//}
