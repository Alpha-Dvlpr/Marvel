//
//  BaseTableView.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 23/3/22.
//

import UIKit

class BaseTableView: UITableView {
    
    func showLoader() {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.startAnimating()
        loader.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 44)
        
        DispatchQueue.main.async {
            self.tableFooterView = loader
            self.tableFooterView?.isHidden = false
        }
    }
    
    func hideLoader() { DispatchQueue.main.async { self.tableFooterView = nil } }
}
