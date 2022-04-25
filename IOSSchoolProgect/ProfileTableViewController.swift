//
//  UserLoginViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 25.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        registerCells()
    }
    
    func registerCells() {
        registerCell(identifire: UserLoginTableViewCell.className)
        registerCell(identifire: RegistrationDateTableViewCell.className)
        registerCell(identifire: ProfileColorTableViewCell.className)
    }
    
    func registerCell(identifire: String) {
        let nib = UINib(nibName: identifire, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifire)
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0,
           let cell = tableView.dequeueReusableCell(withIdentifier: UserLoginTableViewCell.className) as? UserLoginTableViewCell {
            return cell
        }
        if indexPath.row == 1,
           let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationDateTableViewCell.className) as? RegistrationDateTableViewCell {
            return cell
        }
        if indexPath.row == 2,
           let cell = tableView.dequeueReusableCell(withIdentifier: ProfileColorTableViewCell.className) as? ProfileColorTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}
