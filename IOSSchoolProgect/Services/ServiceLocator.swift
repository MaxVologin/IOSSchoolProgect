//
//  ServiceLocator.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 17.05.2022.
//

import Foundation
// сервис локатор
struct ServiceLocator {
    static func characterNetworkManager() -> CharacterNetworManager {
        NetworkManager()
    }
}
