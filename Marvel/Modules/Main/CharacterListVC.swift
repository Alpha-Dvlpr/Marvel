//
//  CharacterListVC.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import UIKit

struct CharacterListViews {
    
    private var tabBar: CustomNavBar = {
        let bar = CustomNavBar.create()
        bar.set(title: Strings.characters.rawValue)
        bar.hideLowerBar()
        
        return bar
    }()
    
    private var characterList: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        
        return table
    }()
    
    func create(inside view: UIView) {
        view.addSubview(self.tabBar)
        view.addSubview(self.characterList)
        
        self.tabBar
            .alignParentTopSafeArea()
            .alignParentLeft(constant: 8)
            .alignParentRight(constant: 8)
        
        self.characterList
            .align(belowTo: self.tabBar)
            .alignParentBottomSafeArea()
            .alignParentLeft()
            .alignParentRight()
    }
    
    func set(_ delegate: UITableViewDelegate, _ dataSource: UITableViewDataSource) {
        self.characterList.delegate = delegate
        self.characterList.dataSource = dataSource
    }
    
    func reload() { DispatchQueue.main.async { self.characterList.reloadData() } }
}

class CharacterListVC: BaseVC {
    
    private var views: CharacterListViews?
    private var viewModel: CharacterListVM?
    
    static func create() -> CharacterListVC {
        let controller = CharacterListVC()
        controller.view.backgroundColor = .black
        controller.views = CharacterListViews()
        controller.views?.create(inside: controller.view)
        controller.viewModel = CharacterListVM(service: NetServices())
        controller.viewModel?.netServices?.manager = ServiceManager()
        controller.configure()
        
        return controller
    }
    
    func configure() {
        func fetch() {
            self.startLoading()
            self.viewModel?.getCharacters()
        }
        
        self.views?.set(self, self)
        self.viewModel?.observer = { [ weak self ] error in
            guard let wSelf = self else { return }
            
            wSelf.stopLoading()
            wSelf.views?.reload()
            
            if let error = error { wSelf.showAlert(for: error) { fetch() } }
        }
        
        fetch()
    }
}

extension CharacterListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let character = self.viewModel?.characters[indexPath.row] {
            return CharacterCell.create(with: character)
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Character not found @ \(indexPath)"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CharacterCell,
              let id = cell.getCharacterId()
        else { return }
        
        Navigator.navigate(to: .characterDetail(characterID: id))
    }
}
