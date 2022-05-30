//
//  AppDelegateStorageManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 30.05.2022.
//

import Foundation

protocol AppDelegateStorageManager {
    func saveNotFirstLaunch(bool: Bool)
    func notFirstLaunch() -> Bool
    func cleanKeychain()
}
