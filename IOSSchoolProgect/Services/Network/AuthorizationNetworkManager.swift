//
//  AuthorizationNetworkManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 18.05.2022.
//

import Foundation

protocol AuthorizationNetworkManager {
    func login(username: String, password: String, completion:((TokenResponse?, Error?) -> ())?)
}
