//
//  CharacterStatus.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 13.05.2022.
//

import Foundation

enum CharacterStatus: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    
    var representedValue: String {
        switch self {
        case .alive:
            return "Живой"
        case .dead:
            return "Мертвый"
        case .unknown:
            return "Неизвестно"
        }
    }
}
