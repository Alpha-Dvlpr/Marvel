//
//  CustomCollectionViewCell.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "CustomCollectionViewCell"
    static var height: CGFloat { return Constants.isPad ? 512 : 256 }
    static var width: CGFloat { return Constants.isPad ? 341 : 170 }
    
    private var image = WebImageView.create()
    
    private var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.isPad ? 24 : 14)
        label.textAlignment = .center
        
        return label
    }()
    
    func create() {
        self.setup()
        self.addSubviews()
    }
    
    private func setup() {
        self.layer.backgroundColor = UIColor.systemPink.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
    }
    
    private func addSubviews() {
        self.addSubview(self.image)
        self.addSubview(self.title)
        
        self.image
            .alignParentTop(constant: 4)
            .matchParentHorizontally(constant: 4)
            .height(constant: CustomCollectionViewCell.height * 0.75)
        
        self.title
            .align(belowTo: self.image, constant: 4)
            .alignParentBottom(constant: 4)
            .matchParentHorizontally(constant: 4)
    }
    
    func configure(with data: ElementData) {
        self.title.text = data.title
        self.image.loadImage(from: data.thumbnail?.url)
    }
}
