//
//  StorageManagerKeychein.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 24.05.2022.
//

import Foundation

protocol KeycheinStorageManager {
    func saveTokenResponseToKeychein(tokenResponse: TokenResponse?)
    func cleanKeychain()
    func loadTokenResponseFromKeychein() -> TokenResponse?
}
