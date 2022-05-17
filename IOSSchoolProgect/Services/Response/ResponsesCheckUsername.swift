//
//  ResponsesCheckUsername.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 15.05.2022.
//

import Foundation

enum ResponsesCheckUsername: String, Decodable {
    case tooShort = "TooShort"
    case tooLong = "TooLong"
    case invalidCharacters = "InvalidCharacters"
    case taken = "Taken"
    case free = "Free"
    
    var representedValue: String {
        switch self {
        case .tooShort:
            return "Имя пользователя короче 3 символов"
        case .tooLong:
            return "Имя пользователя длиннее 16 символов"
        case .invalidCharacters:
            return "Имя пользователя содержит неподдерживаемые символы"
        case .taken:
            return "Имя пользователя занято"
        case .free:
            return "Имя пользователя свободно"
        }
    }
}

