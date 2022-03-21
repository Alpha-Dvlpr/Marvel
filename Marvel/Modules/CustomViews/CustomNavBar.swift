//
//  CustomNavBar.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import UIKit

enum TabBarAction {
    case share
    
    var image: UIImage? {
        switch self {
        case .share: return Images.share.rawValue
        }
    }
    
    var color: UIColor {
        switch self {
        case .share: return .black
        }
    }
}

protocol NavBarProtocol {
    func goBack()
    func actionTapped(action: TabBarAction)
}

class CustomNavBar: UIView {
    
    private var backButton: UIButton = {
        let image = Images.chevronBackwards.rawValue
        let resized = image?.resizeImage(targetSize: CGSize(width: 32, height: 32))
        
        let button = UIButton()
        button.setTitle(Strings.back.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setImage(resized, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 8)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        
        return button
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .black
        
        return label
    }()
    
    private var actions: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        
        return stack
    }()
    
    private var delegate: NavBarProtocol?
    
    static func create() -> CustomNavBar {
        let bar = CustomNavBar()
        bar.addSubviews()
        
        return bar
    }
    
    func set(back: Bool) { self.backButton.isHidden = !back }
    
    func set(title: String) { self.title.text = title.uppercased() }
    
    func set(actions: [TabBarAction]) {
        self.backButton.isUserInteractionEnabled = true
        self.backButton.addTarget(self, action: #selector(self.backButtonTapped(_:)), for: .touchUpInside)
        
        let newViews: [UIView] = actions.map { original in
            let action = TabBarActionSender(target: self, action: #selector(self.actionTapped(_:)))
            action.action = original
            
            let button = UIImageView()
            button.image = original.image
            button.tintColor = original.color
            button.isUserInteractionEnabled = true
            button.addGestureRecognizer(action)
            button
                .width(constant: 46)
                .height(constant: 46)
            
            return button
        }
        
        self.actions.removeArrangedSubviews()
        self.actions.addArrangedSubviews(newViews)
    }
    
    func set(delegate: NavBarProtocol) { self.delegate = delegate }
    
    func hideLowerBar() {
        self.backButton.isHidden = true
        self.actions.isHidden = true
        self.backButton.height(constant: 0)
        self.actions.height(constant: 0)
    }
    
    func addSubviews() {
        self.layer.backgroundColor = UIColor.systemGray.cgColor
        self.layer.cornerRadius = 8
        
        self.addSubview(self.backButton)
        self.addSubview(self.title)
        self.addSubview(self.actions)
        
        self.title
            .alignParentTop(constant: 16)
            .alignParentLeft(constant: 16)
            .alignParentRight(constant: 16)
        
        self.backButton
            .alignParentLeft(constant: 16)
            .align(belowTo: self.title)
            .alignParentBottom(constant: 16)
        
        self.actions
            .alignParentRight(constant: 16)
            .align(belowTo: self.title)
            .alignParentBottom(constant: 16)
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.delegate?.goBack()
    }
    
    @objc private func actionTapped(_ sender: TabBarActionSender) {
        if let action = sender.action {
            self.delegate?.actionTapped(action: action)
        }
    }
}
