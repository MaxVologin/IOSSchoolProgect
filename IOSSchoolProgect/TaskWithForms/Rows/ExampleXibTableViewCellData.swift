//
//  ExampleXibTableViewCellData.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 12.05.2022.
//

import UIKit

class ExampleXibTableViewCellData: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    func configure(title: String, subTitle: String) -> UITableViewCell {
        self.title?.text = title
        self.subTitle?.text = subTitle
        return self
    }
}
