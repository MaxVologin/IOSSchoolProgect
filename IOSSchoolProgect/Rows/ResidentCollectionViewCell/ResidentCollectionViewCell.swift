//
//  ResidentCollectionViewCell.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 31.05.2022.
//

import UIKit

class ResidentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var backView: UIView!

    var id: String?
    
    func configure(resident: Resident) {
        id = resident.image
        nameLabel.text = resident.name
        genderLabel.text = resident.gender.rawValue
        speciesLabel.text = resident.species
    }
    
    func setImage(image: UIImage?) {
        self.spinner.stopAnimating()
        guard let image = image else {
            self.imageView.alpha = 1
            return
        }
        self.imageView.layer.frame = .init(x: 3, y: -4, width: 115, height: 115 )
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        self.imageView.image = image
    }
    
    func startCell() {
        id = nil
        imageView.layer.frame = .init(x: 0, y: 0, width: 121, height: 107)
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "placeholder")
        imageView.alpha = 0.9
        spinner.startAnimating()
    }
}
