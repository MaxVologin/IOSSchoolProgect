//
//  UIView+storyobardParametrs.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 07.04.2022.
//

import UIKit

extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
}
