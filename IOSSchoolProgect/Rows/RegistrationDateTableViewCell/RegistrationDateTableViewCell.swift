//
//  RegistrationDateTableViewCell.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 25.04.2022.
//

import UIKit

class RegistrationDateTableViewCell: UITableViewCell {
    @IBOutlet weak var dateRegistration: UILabel!
    
    func configure(profile: Profile?) -> UITableViewCell {
        guard let subscribersCount = profile?.subscribersCount else {
            dateRegistration.text = "Подписок нет"
            return self
        }
        dateRegistration.text = "Подписок: \(subscribersCount)"
        return self
    }
}
