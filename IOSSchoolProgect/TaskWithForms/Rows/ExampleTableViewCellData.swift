//
//  ExampleTableViewCellData.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 12.05.2022.
//

import UIKit

class ExampleTableViewCellData: UITableViewCell {
    
    func configure(title: String) -> UITableViewCell {
        textLabel?.text = title
        return self
    }
}
