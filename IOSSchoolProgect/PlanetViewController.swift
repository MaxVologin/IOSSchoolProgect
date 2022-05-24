//
//  PlanetViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 27.04.2022.
//

import UIKit

class PlanetViewController: UIViewController {
    
    let networkManager: LocationNetworkManager = NetworkManager()
    
    var info: Info?
    var locations: [Location] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        requestDataLocations(url: "https://rickandmortyapi.com/api/location")
        registerCell()
    }
    
    func registerCell() {
        let nib = UINib(nibName: LocationTableViewCell.className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: LocationTableViewCell.className)
    }
    
    func requestDataLocations(url: String) {
        networkManager.requestDataLocations(url: url) { [ weak self ] (locationsInfo, error) in
            if let error = error {
                print(error)
                return
            }
            self?.info = locationsInfo?.info
            guard let locations = locationsInfo?.locations else {
                return
            }
            self?.locations.append(contentsOf: locations)
            self?.tableView.reloadData()
        }
    }
    
    func transitionToResidentsViewController(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let residentsViewController = storyboard.instantiateViewController(withIdentifier: ResidentsViewController.className) as? ResidentsViewController {
            residentsViewController.residents = locations[index].residents
            navigationController?.pushViewController(residentsViewController, animated: true)
        }
    }
}

extension PlanetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.className) as? LocationTableViewCell {
            cell.configure(location: locations[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension PlanetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let nextPageLocation = info?.next else { return }
        if indexPath.row+2 == locations.count {
            requestDataLocations(url: nextPageLocation)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if locations[indexPath.row].residents.count != 0 {
            transitionToResidentsViewController(index: indexPath.row)
        }
    }
}
