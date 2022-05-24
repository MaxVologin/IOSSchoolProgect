//
//  ImagesService.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 24.05.2022.
//

import UIKit

protocol ImageLoadingService {
    func getImage(urlString: String, completion: @escaping (UIImage?) -> ())
}

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
            self.networkManager.getImage(urlString: urlString) { [ weak self ] (data, error) in
                guard let self = self,
                      error == nil,
                      let data = data
                else {
                    completion(nil)
                    return
                }
                let image = UIImage(data: data)
                self.updateQueue.async { [ weak self ] in
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
