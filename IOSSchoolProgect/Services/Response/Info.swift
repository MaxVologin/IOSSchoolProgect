//
//  Info.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 27.05.2022.
//

import Foundation

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
