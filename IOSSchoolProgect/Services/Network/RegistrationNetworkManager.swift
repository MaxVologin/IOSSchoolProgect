//
//  RegistrationNetworkManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 18.05.2022.
//

import Foundation

protocol RegistrationNetworkManager {
    func checkUsername(username: String, completion: ((CheckUsername?, Error?) -> ())?)
    func register(username: String, password: String, completion: ((TokenResponse?, Error?) -> ())?)
}
