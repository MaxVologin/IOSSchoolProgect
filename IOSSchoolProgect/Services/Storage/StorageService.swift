//
//  StorageManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 15.05.2022.
//

import Foundation
import KeychainAccess

class StorageService: StorageManager {
    
    enum StorageManagerKey: String {
        case token
        case userId
        case notFirstLaunch
        case profileColor
    }
    
    private struct Constants {
        static let serviceId = "StorageManagerKeychain.Service.Id"
    }
    
    func saveToken(tokenResponse: TokenResponse?) {
        guard let tokenResponse = tokenResponse else { return }
        let keychain = Keychain(service: Constants.serviceId)
        do {
            try keychain.set(tokenResponse.token, key: StorageManagerKey.token.rawValue)
            try keychain.set(tokenResponse.userId, key: StorageManagerKey.userId.rawValue)
        } catch {
            print(error as Any)
        }
    }
    
    func cleanKeychain() {
        let keychain = Keychain(service: Constants.serviceId)
        do {
            try keychain.removeAll()
        } catch {
            print(error as Any)
        }
    }
    
    func token() -> TokenResponse? {
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

    func saveNotFirstLaunch(bool: Bool) {
        UserDefaults.standard.set(bool, forKey: StorageManagerKey.notFirstLaunch.rawValue)
    }
    
    func notFirstLaunch() -> Bool {
        UserDefaults.standard.bool(forKey: StorageManagerKey.notFirstLaunch.rawValue)
    }
    
    func saveColorProfile(colorProfileHEX: String) {
        UserDefaults.standard.setValue(colorProfileHEX, forKey: StorageManagerKey.profileColor.rawValue)
    }
    
    func colorProfile() -> String? {
        UserDefaults.standard.string(forKey: StorageManagerKey.profileColor.rawValue)
    }
}
