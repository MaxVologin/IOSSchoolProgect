//
//  ProfileStorageManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 30.05.2022.
//

import Foundation

protocol ProfileStorageManager {
    func token() -> TokenResponse?
    func saveColorProfile(colorProfileHEX: String)
    func colorProfile() -> String?
}
