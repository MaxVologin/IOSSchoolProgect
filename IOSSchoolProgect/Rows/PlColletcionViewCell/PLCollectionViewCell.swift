//
//  PlCollectionViewCell.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 22.04.2022.
//

import UIKit

class PLCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        customView = UIView()
        super.init(frame: frame)
        initialSet()
    }
    
    required init?(coder: NSCoder) {
        customView = UIView()
        super.init(coder: coder)
        initialSet()
    }
    
    let customView: UIView
    
    func initialSet() {
        contentView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        // два варианта построения констреинтов создаются с самым сильным приоритетом
        customView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        NSLayoutConstraint.activate(
            [
                customView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
                customView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
                customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
            ]
        )
    }
}
