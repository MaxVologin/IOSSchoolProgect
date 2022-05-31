//
//  PlanetTableViewCell.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 22.04.2022.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {

    var tapOnLabelClosure: ((String?) -> ())?
    @objc func didTapLabel() {
        tapOnLabelClosure?(textLabel?.text)
    }
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var subTitleLable: UILabel!
//    @IBOutlet weak var detailLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(didTapLabel))
        textLabel?.addGestureRecognizer(tap)
    }
}
