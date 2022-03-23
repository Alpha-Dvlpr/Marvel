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
    
    private var characterList: BaseTableView = {
        let table = BaseTableView()
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
    
    func showTableLoader() { self.characterList.showLoader() }
    
    func hideTableLoader() { self.characterList.hideLoader() }
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
            self.viewModel?.getData()
        }
        
        self.views?.set(self, self)
        self.viewModel?.observer = { [ weak self ] error in
            guard let wSelf = self else { return }
            
            wSelf.stopLoading()
            wSelf.views?.reload()
            wSelf.views?.hideTableLoader()
            
            if let error = error { wSelf.showAlert(for: error) { fetch() } }
        }
        
        fetch()
    }
}

extension CharacterListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let character = self.viewModel?.data[indexPath.row] as? Hero {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSection = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
        
        if indexPath.section == lastSection && indexPath.row == lastRow {
            self.views?.showTableLoader()
            self.viewModel?.getData()
        }
    }
}
