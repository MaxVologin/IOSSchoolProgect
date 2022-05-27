//
//  Location.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 24.05.2022.
//

import Foundation

struct LocationsInfo: Decodable {
    let info: Info
    let locations: [Location]
    
    enum CodingKeys: String, CodingKey {
        case info
        case locations = "results"
    }
}
