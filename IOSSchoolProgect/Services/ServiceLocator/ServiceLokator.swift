//
//  ServiceLokator.swift
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
    
    static func keycheinStorageManager() -> KeycheinStorageManager {
        StorageManager()
    }
    
    static func userDefaultsStorageManager() -> UserDefaultsStorageManager {
        StorageManager()
    }
}
