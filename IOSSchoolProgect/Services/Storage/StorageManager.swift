//
//  StorageManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 24.05.2022.
//

import Foundation

protocol StorageManager {
    func saveToken(tokenResponse: TokenResponse?)
    func cleanKeychain()
    func token() -> TokenResponse?
    func saveNotFirstLaunch(bool: Bool)
    func notFirstLaunch() -> Bool
    func saveColorProfile(colorProfileHEX: String)
    func colorProfile() -> String?
}
