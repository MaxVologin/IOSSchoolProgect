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
        let appDelegateStorageManager = ServiceLocator.storageManager()
        if !appDelegateStorageManager.notFirstLaunch() {
            appDelegateStorageManager.cleanKeychain()
            appDelegateStorageManager.saveNotFirstLaunch(bool: true)
        }
        return true
    }
}

