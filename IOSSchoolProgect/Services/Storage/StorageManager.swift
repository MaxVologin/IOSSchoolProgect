//
//  StorageManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 15.05.2022.
//

import Foundation
import KeychainAccess

class StorageManager {
    
    enum StorageManagerKey: String {
        case token
        case userId
        case notFirstLaunch
    }
    
    private struct Constants {
        static let serviceId = "StorageManagerKeychein.Service.Id"
    }
    
    func saveTokenResponseToKeychein(tokenResponse: TokenResponse?) {
        guard let tokenResponse = tokenResponse else { return }
        let keychain = Keychain(service: Constants.serviceId)
        do {
            try keychain.set(tokenResponse.token, key: StorageManagerKey.token.rawValue)
            try keychain.set(tokenResponse.userId, key: StorageManagerKey.userId.rawValue)
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
    
    func loadTokenResponseFromKeychein() -> TokenResponse? {
        let keychain = Keychain(service: Constants.serviceId)
        do {
            guard let token = try keychain.get(StorageManagerKey.token.rawValue),
                let userId = try keychain.get(StorageManagerKey.userId.rawValue) else {
                return nil
            }
            return TokenResponse(token: token, userId: userId)
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