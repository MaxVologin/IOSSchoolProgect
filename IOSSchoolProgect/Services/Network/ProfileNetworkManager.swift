//
//  ProfileNetworkManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 18.05.2022.
//

import Foundation

protocol ProfileNetworkManager {
    func verification(userId: String, completion:((Profile?, Error?) -> ())?)
}
