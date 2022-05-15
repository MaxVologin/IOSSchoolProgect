//
//  StorageManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 13.05.2022.
//

import KeychainAccess
import Foundation

class StorageManager {
    
    enum StorageManagerKey: String {
        case token
        case notFirstLaunch
    }
    
    private struct Constants {
        static let serviceId = "StorageManagerKeychein.Service.Id"
    }
    
    func saveToKeychein(_ string: String, key: StorageManagerKey) {
        let keychain = Keychain(service: Constants.serviceId)
        do {
            try keychain.set(string, key: key.rawValue)

        } catch {
            print(error as Any)
        }
    }
    
    func claenKeychain() {
        let keychain = Keychain(service: Constants.serviceId)
        do {
            try keychain.removeAll()
        } catch {
            print(error as Any)
        }
    }
    
    func loadFromKeychein(key: StorageManagerKey) -> String? {
        let keychain = Keychain(service: Constants.serviceId)
        do {
            let result = try keychain.get(key.rawValue)
            return result
        } catch {
            print(error as Any)
        }
        return nil
    }
    
    func saveToUserDefaults(bool: Bool, key: StorageManagerKey) {
        UserDefaults.standard.set(bool, forKey: key.rawValue)
    }
    
    func userDefaultsBool(key: StorageManagerKey) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
