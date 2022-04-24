//
//  NSObject+ClassName.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 22.04.2022.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
