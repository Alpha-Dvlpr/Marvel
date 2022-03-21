//
//  WebImageView.swift
//  Marvel
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import UIKit

typealias URLImageCompletion = ((Result<UIImage, Error>) -> Void)

enum URLImageError: Error {
    case loadinFailed
}

protocol URLImage {
    func loadImage(from url: URL?, completion: URLImageCompletion?)
    func clear()
}

class WebImageView: UIImageView, URLImage {
    
    private var disposable: Disposable?
    
    static func create() -> WebImageView {
        let view = WebImageView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }
    
    func loadImage(from url: URL?, completion: URLImageCompletion? = nil) {
        guard let request = self.buildURLRequest(from: url) else { return }
        
        if let image = self.retrieveCachedImage(for: request) {
            self.image = image
        } else {
            self.disposable = self.requestNetImage(request, completion: completion)
        }
    }
    
    func clear() {
        self.image = nil
        self.disposable?.dispose()
    }
    
    private func buildURLRequest(from url: URL?) -> URLRequest? {
        guard let url = url else { return nil }
        
        return URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
    }
    
    private func retrieveCachedImage(for request: URLRequest) -> UIImage? {
        guard let cachedData = URLCache.shared.cachedResponse(for: request)?.data else { return nil }
        
        return UIImage(data: cachedData)
    }
    
    private func requestNetImage(_ request: URLRequest, completion: URLImageCompletion?) -> Disposable {
        let dataTask = URLSession.shared.dataTask(with: request) { [ weak self ] (data, response, _) in
            guard let wSelf = self else { return }
            guard let data = data,
                  let response = response
            else { completion?(.failure(URLImageError.loadinFailed)); return }
            
            wSelf.cacheResponse(from: request, data: data, response: response)
            wSelf.handleNetImage(response: response, data: data, completion: completion)
        }
        
        dataTask.resume()
        
        return dataTask
    }
    
    private func handleNetImage(response _: URLResponse, data: Data, completion: URLImageCompletion?) {
        DispatchQueue.main.async {
            guard let image = UIImage(data: data)
            else { completion?(.failure(URLImageError.loadinFailed)); return }
            
            self.image = image
            completion?(.success(image))
        }
    }
    
    private func cacheResponse(from request: URLRequest, data: Data, response: URLResponse) {
        let cachedData = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedData, for: request)
    }
}
