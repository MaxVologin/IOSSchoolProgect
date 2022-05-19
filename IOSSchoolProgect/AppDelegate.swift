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
        let storageManager = StorageManager()
        if !storageManager.notFirstLaunchFromUserDefaults(key: .notFirstLaunch) {
            storageManager.claenKeychain()
            storageManager.saveNotFirstLaunchToUserDefaults(bool: true, key: .notFirstLaunch)
        }
        return true
    }
}

