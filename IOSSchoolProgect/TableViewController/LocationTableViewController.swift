//
//  LocationTableViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 22.04.2022.
//

import UIKit

class LocationTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var source: [(String, String)] = [
        ("oneTitle", "oneSubTitle"),
        ("FCKY", "BLABLA"),
        ("123124", "efwedfdfsfwf")
    ]

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

extension LocationTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return source.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.nibName) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        let carthage = source[indexPath.row]
        cell.titleLabel.text = carthage.0
        cell.subTitleLabel.text = carthage.1
        return cell
    }
}

extension LocationTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(source[indexPath.row].0)
    }
}
