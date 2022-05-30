//
//  AuthorizationStorageManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 30.05.2022.
//

import Foundation

protocol AuthorizationStorageManager {
    func saveToken(tokenResponse: TokenResponse?)
}
