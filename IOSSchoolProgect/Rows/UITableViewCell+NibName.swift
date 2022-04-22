//
//  UITableViewCell+NibName.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 22.04.2022.
//

import UIKit

public extension UITableViewCell {
    static var nibName: String {
        String(describing: Self.self)
    }
}
