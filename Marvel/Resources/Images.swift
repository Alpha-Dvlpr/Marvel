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
        case .share:
            if #available(iOS 15, *) { return UIImage(systemName: "square.and.arrow.up.circle.fill") }
            return UIImage(systemName: "square.and.arrow.up")
        case .comic: return UIImage(systemName: "book.circle")
        case .series:
            if #available (iOS 15, *) { return UIImage(systemName: "film.circle") }
            return UIImage(systemName: "film")
        case .stories:
            if #available (iOS 15, *) { return UIImage(systemName: "circle.dotted") }
            return UIImage(systemName: "circle.dashed")
        case .events: return UIImage(systemName: "calendar.circle")
        }
    }
}
