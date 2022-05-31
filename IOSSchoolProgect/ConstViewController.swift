//
//  ConstViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 31.05.2022.
//

import UIKit
import AutoLayoutSugar

class ConstViewController: UIViewController {

    var subViewTopConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let subView = UIView()
        subView.backgroundColor = .purple
        view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subViewTopConstraint = subView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        subViewTopConstraint?.isActive = true
        subView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        view.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: 30).isActive = true
        subView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let subView2 = UIView()
        subView2.backgroundColor = .cyan
        subView2.translatesAutoresizingMaskIntoConstraints = false
        subView.addSubview(subView2)
        NSLayoutConstraint.activate([
            subView2.topAnchor.constraint(equalTo: subView.topAnchor, constant: 10),
            subView2.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 50),
            subView2.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -50),
            subView2.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -10)
        ])
    
        let subView3 = UIView()
        subView2.addSubview(subView3)
        subView3.backgroundColor = .red
        subView3.prepareForAutoLayout()
            .top(-20)
            .left(40)
            .right(60)
            .bottom(30)
//        subView.clipsToBounds = true
//        subView.layer.masksToBounds = true
        subView.layer.shadowOpacity = 1
        subView.layer.shadowRadius = 10
        subView.layer.shadowColor = UIColor.black.cgColor
    }
    
    
}
