//
//  Navigator.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import UIKit

enum NavigationTarget {
    case characterList
    case characterDetail(characterID: Int)
    
    var controller: UIViewController {
        switch self {
        case .characterList: return CharacterListVC.create()
        case .characterDetail(let id): return DetailVC.create(with: id)
        }
    }
}

class Navigator {
    
    static var keyWin: UIWindow? {
        return UIApplication.shared.connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first(where: { $0.isKeyWindow })
    }
    
    static func navigate(to target: NavigationTarget) {
        let targetVC = target.controller
        targetVC.modalPresentationStyle = .overFullScreen

        self.performNavigation(to: targetVC)
    }
    
    private static func performNavigation(to controller: UIViewController) {
        Navigator.keyWin?.rootViewController = controller
        Navigator.keyWin?.makeKeyAndVisible()
    }
}
