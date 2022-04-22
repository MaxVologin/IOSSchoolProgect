//
//  PlanetTableViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 22.04.2022.
//

import UIKit

class PlanetTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCell()
    }
    
    func registerTableViewCell() {
        let nib = UINib(nibName: LocationTableViewCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: LocationTableViewCell.nibName)
    }
}

extension PlanetTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension PlanetTableViewController: UITableViewDelegate {
    
}
