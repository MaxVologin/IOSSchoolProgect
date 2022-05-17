//
//  TokenResponse.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 16.05.2022.
//

import Foundation

struct TokenResponse: Decodable {
    let token: String
    let userId: String
}
