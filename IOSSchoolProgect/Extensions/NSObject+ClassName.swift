//
//  NSObject+ClassName.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 25.04.2022.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
