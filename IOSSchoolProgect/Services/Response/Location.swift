//
//  Location.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 27.05.2022.
//

import Foundation

struct Location: Decodable {
    let id: Int
    let name: String
    let type: String
    let residents: [String]
}
