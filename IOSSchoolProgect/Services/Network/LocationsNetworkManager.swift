//
//  LocationNetworkManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 24.05.2022.
//

import Foundation

protocol LocationsNetworkManager {
    var locationsURL: String { get }
    func requestDataLocations(url: String, completion:((LocationsInfo?, Error?) -> ())?)
}
