//
//  Endpoints.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import Foundation

enum Endpoints {
    case baseURL
    case characters
    case character(id: Int)
    case comics(id: Int)
    case series(id: Int)
    case stories(id: Int)
    case events(id: Int)
    
    var rawValue: String {
        switch self {
        case .baseURL: return "https://gateway.marvel.com/v1/public"
        case .characters: return "/characters"
        case .character(let id): return "/characters/\(id)"
        case .comics(let id): return "/comics/\(id)"
        case .series(let id): return "/series/\(id)"
        case .stories(let id): return "/stories/\(id)"
        case .events(let id): return "/events/\(id)"
        }
    }
}
