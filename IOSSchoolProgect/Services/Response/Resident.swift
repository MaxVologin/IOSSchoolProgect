//
//  Resident.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 24.05.2022.
//

import Foundation

struct Resident: Decodable {
    let id: Int
    let name: String
    let species: String
    let gender: Gender
    let image: String
}
