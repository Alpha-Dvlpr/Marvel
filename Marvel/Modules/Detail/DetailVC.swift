//
//  DetailVC.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import UIKit

struct DetailVCViews {
    
    private var tabBar = CustomNavBar.create()
    private var scroll = UIScrollView()
    private var content = UIView()
    
    private var image = WebImageView.create()
    
    private var description: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    private var comicsCollection: CustomCollectionView = {
        let collection = CustomCollectionView.create()
        collection.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        return collection
    }()
    
    private var seriesCollection: CustomCollectionView = {
        let collection = CustomCollectionView.create()
        collection.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        return collection
    }()
    
    private var storiesCollection: CustomCollectionView = {
        let collection = CustomCollectionView.create()
        collection.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        return collection
    }()
    
    private var eventsCollection: CustomCollectionView = {
        let collection = CustomCollectionView.create()
        collection.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        return collection
    }()
    
    init(inside view: UIView) {
        view.addSubview(self.tabBar)
        view.addSubview(self.scroll)
        
        self.tabBar
            .alignParentTopSafeArea()
            .alignParentLeft(constant: 8)
            .alignParentRight(constant: 8)
        
        self.scroll
            .alignHorizontallyWithParent()
            .matchParentHorizontally()
            .align(belowTo: self.tabBar)
            .alignParentBottom()
        
        self.scroll.addSubview(self.content)
        
        self.content
            .alignHorizontallyWithParent()
            .matchParentHorizontally()
            .alignParentTop()
            .alignParentBottom()
        
        self.content.addSubview(self.image)
        self.content.addSubview(self.description)
        self.content.addSubview(self.comicsCollection)
        self.content.addSubview(self.seriesCollection)
        self.content.addSubview(self.storiesCollection)
        self.content.addSubview(self.eventsCollection)
        
        self.image
            .alignParentTop(constant: 16)
            .alignHorizontallyWithParent()
            .matchParentHorizontally(constant: 16)
            .height(constant: Constants.isPad ? 600 : 250)
        
        self.description
            .align(belowTo: self.image, constant: 16)
            .alignHorizontallyWithParent()
            .matchParentHorizontally(constant: 16)
        
        self.comicsCollection
            .align(belowTo: self.description, constant: 8)
            .alignHorizontallyWithParent()
            .matchParentHorizontally(constant: 16)
        
        self.seriesCollection
            .align(belowTo: self.comicsCollection, constant: 8)
            .alignHorizontallyWithParent()
            .matchParentHorizontally(constant: 16)
        
        self.storiesCollection
            .align(belowTo: self.seriesCollection, constant: 8)
            .alignHorizontallyWithParent()
            .matchParentHorizontally(constant: 16)
        
        self.eventsCollection
            .align(belowTo: self.storiesCollection, constant: 8)
            .alignHorizontallyWithParent()
            .matchParentHorizontally(constant: 16)
            .alignParentBottom()
    }
    
    func configure(with delegate: NavBarProtocol) {
        self.tabBar.set(actions: [.share])
        self.tabBar.set(back: true)
        self.tabBar.set(delegate: delegate)
    }
    
    func set(character: Hero?) {
        if let character = character {
            self.tabBar.set(title: character.name)
            self.image.loadImage(from: character.thumbnail.url)
            self.description.text = character.nonEmptyDescription
            self.comicsCollection.setup(with: .comic, and: character.comics.items.map { return $0.elementData }.compactMap { return $0 })
            self.seriesCollection.setup(with: .series, and: character.series.items.map { return $0.elementData }.compactMap { return $0 })
            self.storiesCollection.setup(with: .stories, and: character.stories.items.map { return $0.elementData }.compactMap { return $0 })
            self.eventsCollection.setup(with: .events, and: character.events.items.map { return $0.elementData }.compactMap { return $0 })
        } else {
            self.tabBar.set(title: "")
        }
    }
}

class DetailVC: BaseVC {
    
    private var views: DetailVCViews?
    private var viewModel: DetailVM?
    
    static func create(with characterID: Int) -> DetailVC {
        let controller = DetailVC()
        controller.view.backgroundColor = .black
        controller.views = DetailVCViews(inside: controller.view)
        controller.viewModel = DetailVM(characterID: characterID, services: NetServices())
        controller.viewModel?.netServices?.manager = ServiceManager()
        controller.configure()
        
        return controller
    }
    
    func configure() {
        self.views?.set(character: nil)
        self.views?.configure(with: self)
        
        self.viewModel?.observer = { [ weak self ] error in
            guard let wSelf = self else { return }
            
            wSelf.stopLoading()
            
            DispatchQueue.main.async { wSelf.views?.set(character: self?.viewModel?.character) }
            
            if let error = error { wSelf.showAlert(for: error) }
        }
        
        self.startLoading()
        self.viewModel?.getCharacterData()
    }
}

extension DetailVC: NavBarProtocol {
    
    func goBack() { Navigator.navigate(to: .characterList) }
    
    func actionTapped(action: TabBarAction) {
        switch action {
        case .share: self.viewModel?.share()
        }
    }
}
