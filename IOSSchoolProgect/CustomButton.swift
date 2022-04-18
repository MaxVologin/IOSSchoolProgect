//
//  CustomButton.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 15.04.2022.
//

import UIKit

class CustomButton: UIButton {
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = UIColor(red: 0.192, green: 0.406, blue: 0.958, alpha: 0.75)
            } else {
                backgroundColor = UIColor(red: 0.192, green: 0.406, blue: 0.958, alpha: 1)
            }
            super.isHighlighted = newValue
        }
    }
}
