//
//  BaseVC.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 18/3/22.
//

import UIKit

typealias RetryCallback = (() -> Void)

class BaseVC: UIViewController {

    private static let overlayID = 1_000_000
    
    func startLoading() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.view.isUserInteractionEnabled = false
            self.addOverlay()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.removeOverlay()
        }
    }
    
    func showAlert(for error: Error, retry: RetryCallback? = nil) {
        let alert = UIAlertController(title: Strings.info.rawValue, message: error.localizedDescription, preferredStyle: .alert)
        let okButton = UIAlertAction(title: Strings.accept.rawValue, style: .default) { _ in close() }
        let retryButton = UIAlertAction(title: Strings.retry.rawValue, style: .destructive) { _ in close(); retry?() }
        
        func close() { alert.dismiss(animated: true, completion: nil) }
        
        alert.addAction(okButton)
        if retry != nil { alert.addAction(retryButton) }
        
        DispatchQueue.main.async { self.present(alert, animated: true, completion: nil) }
    }
    
    private func addOverlay() {
        self.removeOverlay()
        
        self.view.layer.zPosition = 10
        
        let overlay: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray
            view.alpha = 0.8
            view.tag = BaseVC.overlayID
            view.layer.zPosition = 100
            
            return view
        }()
        
        let indicator: UIActivityIndicatorView = {
            let view = UIActivityIndicatorView()
            view.style = UIActivityIndicatorView.Style.large
            view.color = .systemBlue
            view.layer.zPosition = 1_000
            
            return view
        }()
        
        overlay.addSubview(indicator)
        self.view.addSubview(overlay)
        
        overlay
            .alignParentTop()
            .alignParentBottom()
            .alignParentLeft()
            .alignParentRight()
        
        indicator.alignCenterWithParent()
        indicator.startAnimating()
    }
    
    private func removeOverlay() {
        let overlay = self.view.viewWithTag(BaseVC.overlayID)
        overlay?.removeFromSuperview()
    }
}
