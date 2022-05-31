//
//  ServiceLocator.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 24.05.2022.
//

import Foundation

struct ServiceLocator {
    static func authorizationNetworkManager() -> AuthorizationNetworkManager {
        NetworkManager()
    }
    
    static func registrationNetworkManager() -> RegistrationNetworkManager {
        NetworkManager()
    }

    static func profileNetworkManager() -> ProfileNetworkManager {
        NetworkManager()
    }

    static func locationsNetworkManager() -> LocationsNetworkManager {
        NetworkManager()
    }
    
    static func residentNetworkManager() -> ResidentNetworkManager {
        NetworkManager()
    }

    static func appDelegateStorageManager() -> AppDelegateStorageManager {
        StorageManager()
    }
 
    static func authorizationStorageManager() -> AuthorizationStorageManager {
        StorageManager()
    }
    
    static func registrationStorageManager() -> RegistrationStorageManager {
        StorageManager()
    }
    
    static func profileStorageManager() -> ProfileStorageManager {
        StorageManager()
    }
    
    static func imageNetworkManager() -> ImageNetworkManager {
        NetworkManager()
    }
    
    static let imageLoadingService = ImageService(networkManager: imageNetworkManager())
    
    static func imageService() -> ImageLoadingService {
        imageLoadingService
    }
}
