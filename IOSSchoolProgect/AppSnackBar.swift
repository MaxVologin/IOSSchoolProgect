//
//  AppSnackBar.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 15.05.2022.
//

import UIKit
import SnackBar

class AppSnackBar: SnackBar {
    
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .black
        style.textColor = .white
        style.font = UIFont.systemFont(ofSize: UIFontMetrics.default.scaledValue(for: 24))
        return style
    }
    
    static func showSnackBar(in view: UIView?, message: String) {
        if let view = view {
            AppSnackBar.make(in: view, message: message, duration: .lengthLong).show()
        }
    }
}
