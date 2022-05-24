//
//  ServiceLocator.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 17.05.2022.
//

import Foundation

struct ServiceLocator {
    static func characterNetworkManager() -> CharacterNetworManager {
        NetworkManager()
    }
    
    static func imageNetworkManager() -> ImageNetworkManager {
        NetworkManager()
    }
    
    static let imageLoadingService = ImageService(networkManager: imageNetworkManager())
    
    static func imageService() -> ImageLoadingService {
        imageLoadingService
    }
}
