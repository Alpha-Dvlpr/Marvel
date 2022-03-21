//
//  CharacterCell.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import UIKit

struct CharacterCellViews {
    
    private var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.backgroundColor = UIColor.systemPink.cgColor
        
        return view
    }()
    
    private var name: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.isPad ? 2 : 1
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: Constants.isPad ? 48 : 32)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    private var description: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    private var image = WebImageView.create()
    
    private var sideStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 6
        
        return stack
    }()
    
    private var accessoryView: UIImageView = {
        let view = UIImageView()
        view.image = Images.chevronForward.rawValue
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private var footerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.backgroundColor = UIColor.systemGray.cgColor
        
        return view
    }()
    
    init(inside view: UIView) {
        view.addSubview(self.container)
        view.addSubview(self.footerView)
        
        self.container
            .alignParentTop(constant: 4)
            .align(aboveTo: self.footerView, constant: 4)
            .alignParentLeft(constant: 16)
            .alignParentRight(constant: 16)
        
        self.footerView
            .alignParentBottom()
            .alignParentLeft(constant: 32)
            .alignParentRight(constant: 32)
            .height(constant: 4)
        
        self.container.addSubview(self.accessoryView)
        self.container.addSubview(self.image)
        self.container.addSubview(self.sideStack)
        self.container.addSubview(self.name)
        
        self.accessoryView
            .alignVerticallyWithParent()
            .alignParentRight(constant: 16)
            .width(constant: 48)
            .height(constant: 48)
        
        Constants.isPad ? self.padSetup() : self.phoneSetup()
    }
    
    func set(character: Hero) {
        self.setSideBar(for: character)
        self.name.text = character.name
        self.image.loadImage(from: character.thumbnail.url)
        
        if Constants.isPad { self.description.text = character.nonEmptyDescription }
    }
    
    func clear() { self.image.clear() }
    
    private func padSetup() {
        let spacing = UIView()
        spacing.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        self.container.addSubview(self.description)
        self.container.addSubview(spacing)
        
        self.image
            .alignParentTop(constant: 16)
            .alignParentBottom(constant: 16)
            .alignParentLeft(constant: 16)
            .width(constant: 400)
        
        self.name
            .alignParentTop(constant: 16)
            .align(toRightOf: self.image, constant: 16)
            .align(toLeftOf: self.accessoryView, constant: 16)
        
        self.sideStack
            .alignParentBottom(constant: 16)
            .align(toRightOf: self.image, constant: 16)
            .align(toLeftOf: self.accessoryView, constant: 16)
            .height(constant: 72)
        
        self.description
            .align(belowTo: self.name, constant: 16)
            .align(toRightOf: self.image, constant: 16)
            .align(toLeftOf: self.accessoryView, constant: 16)
        
        spacing
            .align(belowTo: self.description, constant: 16)
            .align(aboveTo: self.sideStack, constant: 16)
            .align(toRightOf: self.image, constant: 16)
            .align(toLeftOf: self.accessoryView, constant: 16)
    }
    
    private func phoneSetup() {
        self.sideStack
            .alignParentBottom(constant: 16)
            .alignParentLeft(constant: 16)
            .alignParentRight(constant: 16)
            .height(constant: 32)
        
        self.name
            .alignParentTop(constant: 16)
            .alignParentLeft(constant: 16)
            .alignParentRight(constant: 16)
            .height(constant: 40)
        
        self.image
            .align(aboveTo: self.sideStack, constant: 8)
            .alignParentLeft(constant: 8)
            .align(toLeftOf: self.accessoryView, constant: 12)
            .align(belowTo: self.name, constant: 8)
    }
    
    private func setSideBar(for character: Hero) {
        let comics = MiniInfoView.create()
        comics.configureView(with: .comic, and: character.comics.available)
        
        let series = MiniInfoView.create()
        series.configureView(with: .series, and: character.series.available)
        
        let stories = MiniInfoView.create()
        stories.configureView(with: .stories, and: character.stories.available)
        
        let events = MiniInfoView.create()
        events.configureView(with: .events, and: character.events.available)
        
        let subviews: [UIView] = [UIView(), comics, series, stories, events]
        
        self.sideStack.addArrangedSubviews(subviews)
    }
}

class CharacterCell: UITableViewCell {

    static var cellHeight: CGFloat { Constants.isPad ? 650 : 300 }
    private var views: CharacterCellViews?
    private var id: Int?
    
    static func create(with character: Hero) -> CharacterCell {
        let view = CharacterCell()
        view.backgroundColor = .clear
        view.views = CharacterCellViews(inside: view)
        view.views?.set(character: character)
        view.id = character.id
        
        return view
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.views?.clear()
    }
    
    func getCharacterId() -> Int? { return self.id }
}
