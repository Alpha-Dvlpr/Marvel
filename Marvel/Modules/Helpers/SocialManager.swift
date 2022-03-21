//
//  SocialManager.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import UIKit

class SocialManager {
    
    static let shared = SocialManager()
    
    func share(hero: Hero) {
        let title = Strings.shareTitle.rawValue
        let heroName = String(
            format: Strings.shareName.rawValue,
            hero.name,
            hero.nonEmptyDescription
        )
        let totalEvents = String(
            format: Strings.shareDescription.rawValue,
            "\(hero.comics.items.count)",
            "\(hero.series.items.count)",
            "\(hero.stories.items.count)",
            "\(hero.events.items.count)"
        )
        
        let controller = UIActivityViewController(
            activityItems: [title.appending(heroName).appending(totalEvents)],
            applicationActivities: nil
        )
        
        Navigator.keyWin?.rootViewController?.present(controller, animated: true, completion: nil)
    }
}
