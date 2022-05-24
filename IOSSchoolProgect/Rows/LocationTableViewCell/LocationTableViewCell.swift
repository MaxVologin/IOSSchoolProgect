//
//  LocationTableViewCell.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 24.05.2022.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var residentsLabel: UILabel!
    
    func configure(location: Location) {
        nameLabel.text = location.name
        typeLabel.text = location.type
        if location.residents.count == 0 {
            residentsLabel.alpha = 0.6
        }
        residentsLabel.text = "Население: \(location.residents.count)"
    }
}
