//
//  ProfileStorageManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 30.05.2022.
//

import UIKit

protocol ProfileStorageManager {
    func token() -> TokenResponse?
    func saveColorProfile(colorProfileHEX: String)
    func colorProfile() -> String?
    func saveProfileImage(image: UIImage)
    func profileImage(completion: (UIImage)->())
}
