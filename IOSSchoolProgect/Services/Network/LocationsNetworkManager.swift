//
//  LocationNetworkManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 24.05.2022.
//

import Foundation

protocol LocationsNetworkManager {
    func requestDataLocations(url: String, completion:((LocationsInfo?, Error?) -> ())?)
}