//
//  StorageManagerUserDefaults.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 24.05.2022.
//

import Foundation

protocol UserDefaultsStorageManager {
    func saveNotFirstLaunchToUserDefaults(bool: Bool)
    func notFirstLaunchFromUserDefaults() -> Bool
    func saveColorProfiletoUserDefaults(colorProfileHEX: String)
    func loadColorProfileFromUserDefaults() -> String?
}
