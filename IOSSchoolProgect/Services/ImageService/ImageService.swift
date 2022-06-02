//
//  ImageService.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 31.05.2022.
//

import UIKit

class ImageService: ImageLoadingService {
    
    init(networkManager: ImageNetworkManager) {
        self.networkManager = networkManager
    }
    
    private let networkManager: ImageNetworkManager
    
    private var imageDictionary: [String: UIImage] = [:]
    private let updateQueue = DispatchQueue(label: "ImageServiceQueue")
    
    func getImage(urlString: String, completion: @escaping (UIImage?) -> ()) {
        if let image = imageDictionary[urlString] {
            completion(image)
            return
        }
        DispatchQueue.global().async {
            self.networkManager.getImage(urlString: urlString) { [ weak self ] data in
                guard let data = data else { return }
                let image = UIImage(data: data)
                self?.updateQueue.async {
                    self?.cleanImageDictionaryIfNeeded()
                    self?.imageDictionary[urlString] = UIImage(data: data)
                    completion(image)
                }
            }
        }
    }
    
    private func cleanImageDictionaryIfNeeded() {
        let allKeys = imageDictionary.keys
        guard allKeys.count > 50 else {
            return
        }
        let firstKeys = allKeys.prefix(allKeys.count - 50)
        for key in firstKeys {
            imageDictionary[key] = nil
        }
    }
}
