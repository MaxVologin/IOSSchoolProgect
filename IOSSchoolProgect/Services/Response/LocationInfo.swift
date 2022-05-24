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

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Location: Decodable {
    let id: Int
    let name: String
    let type: String
    let residents: [URL]
}
