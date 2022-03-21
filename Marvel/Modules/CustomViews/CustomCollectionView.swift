//
//  CustomCollectionView.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import UIKit

class CustomCollectionView: UIView {
    
    private var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .white
        
        return label
    }()
    
    private var noData: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        
        return label
    }()
    
    private var collection: UICollectionView!
    
    private var data: [ElementData] = []
    private var type: MiniViewType?
    
    static func create() -> CustomCollectionView {
        let view = CustomCollectionView()
        view.addSubviews()
        
        return view
    }
    
    func addSubviews() {
        self.configureCollection()
        
        self.addSubview(self.title)
        self.addSubview(self.noData)
        self.addSubview(self.collection)
        
        self.title
            .alignParentTop(constant: 8)
            .matchParentHorizontally()
            .alignParentTop()
        
        self.noData
            .align(belowTo: self.title, constant: 8)
            .matchParentHorizontally(constant: 8)
        
        self.collection
            .align(belowTo: self.noData, constant: 8)
            .matchParentHorizontally(constant: 8)
            .alignParentBottom()
    }
    
    func setup(with type: MiniViewType, and data: [ElementData]) {
        self.title.text = type.title
        self.data = data
        self.type = type
        
        if data.isEmpty {
            self.collection.isHidden = true
            self.collection.height(constant: 0)
            self.noData.text = Strings.noData.rawValue
            self.noData.height(constant: 24)
        } else {
            self.collection.isHidden = false
            self.collection.height(constant: CustomCollectionViewCell.height)
            self.noData.text = ""
            self.noData.height(constant: 0)
        }
        
        self.collection.dataSource = self
        self.collection.delegate = self
        
        self.collection.reloadData()
    }
    
    private func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.itemSize = CGSize(width: CustomCollectionViewCell.width, height: CustomCollectionViewCell.height)
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.reuseID)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        
        self.collection = collection
    }
}

extension CustomCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.reuseID,
            for: indexPath
        ) as? CustomCollectionViewCell {
            cell.create()
            cell.configure(with: self.data[indexPath.row])

            return cell
        } else {
            return UICollectionViewCell(frame: CGRect.zero)
        }
    }
}
