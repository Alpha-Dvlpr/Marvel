//
//  Extensions.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import UIKit

extension TimeInterval {
    
    static var current: TimeInterval { return Date().timeIntervalSince1970 }
}

extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage? {
        let widthRatio = targetSize.width / self.size.width
        let heightRatio = targetSize.height / self.size.height
        let scaleFactor = min(widthRatio, heightRatio)
        
        let scaledImageSize = CGSize(
            width: self.size.width * scaleFactor,
            height: self.size.height * scaleFactor
        )
        
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize )
        
        let scaledImage = renderer.image { _ in self.draw(in: CGRect(origin: .zero, size: scaledImageSize)) }
        
        return scaledImage
    }
}

extension UIStackView {
    
    func removeArrangedSubviews() { self.arrangedSubviews.forEach { $0.removeFromSuperview() } }
    
    func addArrangedSubviews(_ subviews: [UIView]) { subviews.forEach { self.addArrangedSubview($0) } }
}

extension URLSessionDataTask: Disposable {
    
    func dispose() { self.cancel() }
}
