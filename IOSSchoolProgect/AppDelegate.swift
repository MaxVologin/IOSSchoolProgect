//
//  AppDelegate.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 06.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let keycheinStorageManager = ServiceLocator.keycheinStorageManager()
        let userDefaultsStorageManager = ServiceLocator.userDefaultsStorageManager()
        if !userDefaultsStorageManager.notFirstLaunchFromUserDefaults() {
            keycheinStorageManager.cleanKeychain()
            userDefaultsStorageManager.saveNotFirstLaunchToUserDefaults(bool: true)
        }
        return true
    }
}

