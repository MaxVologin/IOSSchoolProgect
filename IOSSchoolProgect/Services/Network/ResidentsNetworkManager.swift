//
//  ResidentsNetworkManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 31.05.2022.
//

import Foundation

protocol ResidentNetworkManager {
    func requestResident(url: String, completion:((Resident?, Error?) -> ())?)
}
