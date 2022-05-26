//
//  LocationTableViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 22.04.2022.
//

import UIKit

class LocationTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var source: [(String, String, String)] = []
    let imageService = ServiceLocator.imageService()
    
    

    override func viewDidLoad() {
        
        for i in 10..<250 {
            source.append(("Character: \(i)", "123", "https://rickandmortyapi.com/api/character/avatar/\(i).jpeg"))
        }
        
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
//    func numberOfSections(in tableView: UITableView) -> Int {
//        3
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        String(section)
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.nibName) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        let carthage = source[indexPath.row]
        cell.titleLabel.text = carthage.0
        cell.subTitleLabel.text = carthage.1
        cell.id = carthage.2
        cell.personIcon.image = nil
        DispatchQueue.global().async {
            self.imageService.getImage(urlString: carthage.2) { (image) in
                if cell.id == carthage.2 {
                    DispatchQueue.main.async {
                        cell.personIcon.image = image
                    }
                }
            }
        }
        return cell
    }
}

extension LocationTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(source[indexPath.row].0)
    }
}
