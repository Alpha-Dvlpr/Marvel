//
//  Images.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import UIKit

enum Images {
    case chevronForward
    case chevronBackwards
    case share
    case comic
    case series
    case stories
    case events
    
    var rawValue: UIImage? {
        switch self {
        case .chevronForward: return UIImage(systemName: "chevron.forward.circle.fill")
        case .chevronBackwards: return UIImage(systemName: "chevron.backward.circle.fill")
        case .share: return UIImage(systemName: "square.and.arrow.up.circle.fill")
        case .comic: return UIImage(systemName: "book.circle")
        case .series: return UIImage(systemName: "film.circle")
        case .stories: return UIImage(systemName: "circle.dotted")
        case .events: return UIImage(systemName: "calendar.circle")
            
            
        }
    }
}
