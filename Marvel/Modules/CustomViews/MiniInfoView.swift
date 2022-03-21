//
//  MiniInfoView.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import UIKit

enum MiniViewType {
    case comic
    case series
    case stories
    case events
    
    var title: String {
        switch self {
        case .comic: return Strings.comics.rawValue
        case .series: return Strings.series.rawValue
        case .stories: return Strings.stories.rawValue
        case .events: return Strings.events.rawValue
        }
    }
    
    var image: UIImage? {
        switch self {
        case .comic: return Images.comic.rawValue
        case .series: return Images.series.rawValue
        case .stories: return Images.stories.rawValue
        case .events: return Images.events.rawValue
        }
    }
}

class MiniInfoView: UIView {
    
    private var image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        
        return view
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: Constants.isPad ? 30 : 18)
        label.textColor = .black
        
        return label
    }()
    
    static func create() -> MiniInfoView {
        let view = MiniInfoView()
        view.setBorder()
        view.addSubviews()
        
        return view
    }
    
    func configureView(with type: MiniViewType, and quantity: Int) {
        self.image.image = type.image
        self.label.text = "\(quantity)"
    }
    
    private func setBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 8
    }
    
    private func addSubviews() {
        self.addSubview(self.image)
        self.addSubview(self.label)
        
        self.image
            .alignVerticallyWithParent()
            .alignParentLeft(constant: 4)
            .width(constant: Constants.isPad ? 52 : 26)
            .height(constant: Constants.isPad ? 52 : 26)
        
        self.label
            .alignParentTop(constant: 8)
            .alignParentBottom(constant: 8)
            .align(toRightOf: self.image, constant: 4)
            .alignParentRight(constant: 8)
    }
}
