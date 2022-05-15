//
//  CharacterGender.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 13.05.2022.
//

import Foundation

enum Gender: String, Decodable {
    case Female
    case Male
    case Genderless
    case unknown
    
    var representedValue: String {
        switch self {
        case .Female:
            return "Женский"
        case .Male:
            return "Мужской"
        case .Genderless:
            return "Бесполый"
        case .unknown:
            return "Неизвестно"
        }
    }
}
